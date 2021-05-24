# Hot to run the lambda locally

* set AWS credentials in shell
* run

    ```# sam build ```

    ``` # sam local invoke -e events/event.json --docker-network host ```
