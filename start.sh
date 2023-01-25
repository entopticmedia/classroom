jupyter kernelgateway \
    --KernelGatewayApp.api='kernel_gateway.notebook_http' \
    --KernelGatewayApp.seed_uri='./classroom_backend.ipynb' \
    --KernelGatewayApp.prespawn_count=10 \
    --KernelGatewayApp.port=8891 \
    --KernelGatewayApp.allow_origin='https://(entoptic.media|designresearch.works)'
