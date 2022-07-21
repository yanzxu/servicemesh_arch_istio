IMAGE_TAG=$1

if test -z "$(kubectl get deploy deployment-account-service -n bookstore-servicemesh)"; then
    echo "******* deployment-account-service not exist, create new deployment with tag: $IMAGE_TAG *******"
    sed -e "s/{IMAGE_TAG}/$IMAGE_TAG/g" deployment-account-service-template.yaml > deployment-account-service.yaml;
    kubectl apply -f ./deployment-account-service.yaml
    kubectl apply -f ./svc-account-service.yaml
#    rm -rf ./deployment-account-service.yaml
else
    echo "******* deployment-account-service already exist, update image tag to: $IMAGE_TAG *******"
    kubectl set image deployment/deployment-account-service servicemesh-account=yanzxu/servicemesh-account:"$IMAGE_TAG" -n bookstore-servicemesh
fi
