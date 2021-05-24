const AWS = require('aws-sdk');
const ecs = new AWS.ECS({ apiVersion: '2014-11-13' });
const codedeploy = new AWS.CodeDeploy({ apiVersion: '2014-10-06' });

class DeploymentStrategy {
    constructor(service, cluster, waiter) {
        this.service = service;
        this.cluster = cluster;
        this.waiter = waiter;

        this.maxAttempts = (waiter.max_wait_minutes * 60) / waiter.wait_delay_sec;
    }

    identify() {
        console.info('Parent');
    }
}


class ClassicStrategy extends DeploymentStrategy {
    constructor(service, cluster, waiter) {
        super(service, cluster, waiter);
    }

    waitForServiceStability() {
        return ecs.waitFor('servicesStable', {
            services: [this.service],
            cluster: this.cluster,
            $waiter: {
                delay: this.waiter.wait_delay_sec,
                maxAttempts: this.maxAttempts
            }
        }).promise();
    }

    identify() {
        return "Classic";
    }
}

class BlueGreenStrategy extends DeploymentStrategy {
    constructor(service, cluster, waiter) {
        super(service, cluster, waiter);
    }

    async waitForServiceStability() {
        const result = await this._getDeploymentId();
        if (result.deployments.length == 0) {
            throw new Error("No BleuGreen deployemts found!");
        }

        //take first in array meaning last one
        const currentDeplId = result.deployments[0];

        return codedeploy.waitFor('deploymentSuccessful', {
            deploymentId: currentDeplId,
            $waiter: {
                delay: this.waiter.wait_delay_sec,
                maxAttempts: this.maxAttempts
            }
        }).promise();
    }

    _getDeploymentId() {
        return codedeploy.listDeployments({
            applicationName: this.service,
            createTimeRange: {
                end: null,
                start: null
            },
            deploymentGroupName: this.service,
            includeOnlyStatuses: ["InProgress"]
        }).promise();
    }

    identify() {
        return "BlueGreen";
    }
}

class DeploymentStrategyDelegator {

    static CLASSIC(service, cluster, waiter) {
        return new ClassicStrategy(service, cluster, waiter);
    }

    static BLUEGREEN(service, cluster, waiter) {
        return new BlueGreenStrategy(service, cluster, waiter);
    }
}

module.exports = { DeploymentStrategyDelegator }
