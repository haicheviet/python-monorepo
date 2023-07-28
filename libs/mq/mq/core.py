import pika


def main() -> None:
    print(f"Go for mq version: {pika.__version__}")
