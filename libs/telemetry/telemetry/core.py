from opentelemetry import trace

tracer = trace.get_tracer("__name__")


@tracer.start_as_current_span("main")
def main() -> None:
    print("Go for opentelemetry")


if __name__ == "__main__":
    main()
