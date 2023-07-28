from opentelemetry import trace

tracer = trace.get_tracer("__name__")


def main() -> None:
    with tracer.start_as_current_span("main") as rollspan:
        print("Go for opentelemetry")
        rollspan.set_attribute("roll", 1)
