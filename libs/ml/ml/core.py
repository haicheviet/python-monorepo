import torch
from telemetry.core import main


def sum_two_tensor(tensor_a: torch.Tensor, tensor_b: torch.Tensor) -> torch.Tensor:
    return tensor_a + tensor_b


def call_telemetry_function() -> None:
    main()
