resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${local.identifier}-dashboard"

  dashboard_body = <<EOF
  {
      "widgets": [
          {
              "type": "metric",
              "x": 0,
              "y": 0,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", "${module.rds.id}" ]
                  ]
              }
          },
          {
              "type": "metric",
              "x": 6,
              "y": 0,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "WriteLatency", "DBInstanceIdentifier", "${module.rds.id}" ],
                      [ ".", "ReadLatency", ".", "." ]
                  ]
              }
          },
          {
              "type": "metric",
              "x": 12,
              "y": 0,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "WriteThroughput", "DBInstanceIdentifier", "${module.rds.id}" ],
                      [ ".", "ReadThroughput", ".", "." ]
                  ]
              }
          },
          {
              "type": "metric",
              "x": 18,
              "y": 0,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "FreeableMemory", "DBInstanceIdentifier", "${module.rds.id}" ]
                  ]
              }
          },
          {
              "type": "metric",
              "x": 0,
              "y": 6,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${module.rds.id}" ]
                  ]
              }
          },
          {
              "type": "metric",
              "x": 6,
              "y": 6,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "ReadIOPS", "DBInstanceIdentifier", "${module.rds.id}" ],
                      [ ".", "WriteIOPS", ".", "." ]
                  ]
              }
          },
          {
              "type": "metric",
              "x": 12,
              "y": 6,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "DiskQueueDepth", "DBInstanceIdentifier", "${module.rds.id}" ]
                  ]
              }
          },
          {
              "type": "metric",
              "x": 18,
              "y": 6,
              "width": 6,
              "height": 6,
              "properties": {
                  "view": "timeSeries",
                  "stacked": false,
                  "region": "eu-west-1",
                  "metrics": [
                      [ "AWS/RDS", "NetworkReceiveThroughput", "DBInstanceIdentifier", "${module.rds.id}" ],
                      [ ".", "NetworkTransmitThroughput", ".", "." ]
                  ]
              }
          }
      ]
  }
   EOF
}
