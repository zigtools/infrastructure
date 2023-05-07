#!/usr/bin/env python3

import os
from grpc import secure_channel, ssl_channel_credentials
from opentelemetry import trace
from opentelemetry.trace import SpanKind
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.sdk.resources import Resource

resource = Resource(attributes={
    "service.name": "my_service"
})

trace.set_tracer_provider(TracerProvider(resource=resource))

cert_file = open(os.path.abspath(os.path.join(__file__, "../../data/caddy/data/caddy/certificates/local/localhost/localhost.crt")), "rb")
cert = cert_file.read()
cert_file.close()

otlp_exporter = OTLPSpanExporter(endpoint="https://localhost:4317", insecure=True, credentials=ssl_channel_credentials(cert))

trace.get_tracer_provider().add_span_processor(
    BatchSpanProcessor(otlp_exporter)
)

tracer = trace.get_tracer(__name__)

for i in range(0, 100):
    with tracer.start_as_current_span("foo", kind=SpanKind.SERVER):
        with tracer.start_as_current_span("bar", kind=SpanKind.SERVER):
            with tracer.start_as_current_span("baz", kind=SpanKind.SERVER):
                print("Hello world from OpenTelemetry Python!")