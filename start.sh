jupyter kernelgateway \
    --KernelGatewayApp.api='kernel_gateway.notebook_http' \
    --KernelGatewayApp.seed_uri='./classroom_backend.ipynb' \
    --KernelGatewayApp.prespawn_count=1 \
    --KernelGatewayApp.port=8889 \
    --KernelGatewayApp.allow_origin='https://(entoptic.media|designresearch.works)'
