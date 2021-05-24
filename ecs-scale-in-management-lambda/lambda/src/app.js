const AWS = require("aws-sdk");
const S3 = new AWS.S3();
const AS = new AWS.ApplicationAutoScaling({apiVersion: '2016-02-06'});

let response;

/**
 *  Lambda is dedicated for enabling, disabling disableScaleIn parameter in TargetTrackingScaling 
 *
 * @param {*} event should contain body.policyNames separated by comma, body.disableScaleIn (true, false)
 * @param {*} context
 * @author Eugeniusz Neugebauer
 *
 */
exports.lambdaHandler = async (event, context) => {
    try {
        //Input parameters
        let policyNames;
        let disableScaleIn;
        if (event.body) {
            if (event.body.hasOwnProperty('policyNames')){
                policyNames = event.body.policyNames;
            }
            if (event.body.hasOwnProperty('disableScaleIn')){
                disableScaleIn = event.body.disableScaleIn;
            }
        }
        else {
            policyNames = event.policyNames;
            disableScaleIn = event.disableScaleIn;
        }
        //disableScaleIn is boolean
        if ( !policyNames || typeof disableScaleIn === 'undefined') {
            throw "Parameters missing, policyName or/and disableScaleIn";
        }

        // change ScalingIn for all scaling policies
        const policyNamesTab = policyNames.split(",");
        for (let i = 0; i < policyNamesTab.length; i++) {
            //Get the current policy data
            let currentPolicyData = await getScalingPolicyDetails(policyNamesTab[i]);
            if (currentPolicyData.ScalingPolicies.length == 0 ) {
                throw "Could not find scaling policy " + policyNamesTab[i];
            }
            //Set disableScaleIn parameter
            await modifyTargetScalingInForPolicy(currentPolicyData.ScalingPolicies[0], disableScaleIn);
        }

    } catch (err) {
        console.log(err);
        return getResponseObject(500, err);
    }

    return getResponseObject(200, "Success");
};


const getScalingPolicyDetails = (policyName) => {
    return new Promise((resolve, reject) => {
        const params = {
            ServiceNamespace: "ecs",
            PolicyNames: [policyName]

        };
        AS.describeScalingPolicies(params, function(err, data) {
            if (err) {
                reject(err);
            }
            else {
                resolve(data);
            }
        });
    });
};

const modifyTargetScalingInForPolicy = (currentPolicyData, disableScaleIn) => {
    return new Promise((resolve, reject) => {
        let params = prepareInputForPutScalingPolicy(currentPolicyData, disableScaleIn);

        AS.putScalingPolicy(params, function(err, data) {
            if (err) {
                reject(err);
            }
            else {
                console.log("Modified policy " + currentPolicyData.PolicyName + " disable scale in = " + disableScaleIn);
                resolve(data);
            }
        });
    });    
}


const prepareInputForPutScalingPolicy = (policyData, disableScaleIn) => {

    delete policyData.Alarms;
    delete policyData.CreationTime;
    delete policyData.PolicyARN;
    policyData.TargetTrackingScalingPolicyConfiguration.DisableScaleIn = disableScaleIn;
    return policyData;
}

const getResponseObject = (code, msg) =>  {
    return response = {
        'statusCode': code,
        'body': JSON.stringify({
            message: msg
        })
    }
}