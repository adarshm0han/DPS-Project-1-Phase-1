set -e

IP=$(minikube ip)
PORT=$(kubectl get svc kafka-neo4j-connect \
        -o jsonpath='{.spec.ports[0].nodePort}')

CONFIG_JSON="Step-3 Refs/sink.neo4j.json"

echo "Registering Neo4j  sink connector..."

curl -X POST \
    -H "Content-Type: application/json" \
    --data @"$CONFIG_JSON" \
    http://$IP:$PORT/connectors

echo "Done. Check status with:"
echo "  curl http://$IP:$PORT/connectors/neo4j-sink/status"