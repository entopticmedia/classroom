jupyter kernelgateway \
    --KernelGatewayApp.api='kernel_gateway.notebook_http' \
    --KernelGatewayApp.seed_uri='./classroom_backend.ipynb' \
    --KernelGatewayApp.prespawn_count=5 \
    --KernelGatewayApp.port=8891
