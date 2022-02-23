batch_workers_set = ["batch_worker_0", "batch_worker_1"]
batch_workers_obj = {
    batch_worker_0 = "t3.micro"
    batch_worker_1 = "t3.medium"
}
batch_workers_nested = {
    worker_0 = {
        name = "batch_worker_0"
        instance_type = "t3.micro"
    }
    worker_1 = {
        name = "batch_worker_1"
        instance_type = "t3.medium"
    }
}