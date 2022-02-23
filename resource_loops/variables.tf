variable "batch_workers_set" {
    type = list(string)
}

variable "batch_workers_obj" {
    type = object({})
}

variable "batch_workers_nested" {
    type = map(object({
        name = string 
        instance_type = string
    }))
}