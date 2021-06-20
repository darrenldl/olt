open Core

let encode_all_upfront = true

let rounds = 200

let setups =
  [
    make_setup ~systematic:true ~encode_all_upfront ~data_block_count:100
      ~max_redundancy:0.20 ~data_block_size:490 ~data_loss_rate:0.01 ~rounds;
    make_setup ~systematic:true ~encode_all_upfront ~data_block_count:100
      ~max_redundancy:0.20 ~data_block_size:4000 ~data_loss_rate:0.02 ~rounds;
    make_setup ~systematic:true ~encode_all_upfront ~data_block_count:100
      ~max_redundancy:0.20 ~data_block_size:4000 ~data_loss_rate:0.01 ~rounds;
    make_setup ~systematic:true ~encode_all_upfront ~data_block_count:100
      ~max_redundancy:0.20 ~data_block_size:4000 ~data_loss_rate:0.005 ~rounds;
  ]

let () =
  Random.self_init ();
  List.iter run_and_print setups
