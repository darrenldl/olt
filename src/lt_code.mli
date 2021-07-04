module Param : sig
  type t

  val systematic : t -> bool

  val data_block_count : t -> int

  val max_drop_count : t -> int

  val make : systematic:bool -> data_block_count:int -> max_drop_count:int -> t
end

val gen_degrees : deterministic:bool -> Param.t -> int array

type encoder

val create_encoder :
  deterministic_degrees:bool ->
  data_blocks:Cstruct.t array ->
  drop_data_buffer:Cstruct.t array ->
  Param.t ->
  encoder

val reset_encoder : encoder -> unit

val param_of_encoder : encoder -> Param.t

val encoder_is_systematic : encoder -> bool

val data_block_count_of_encoder : encoder -> int

val max_drop_count_of_encoder : encoder -> int

val data_block_size_of_encoder : encoder -> int

val data_blocks_of_encoder : encoder -> Cstruct.t array

val encode_one : encoder -> unit

val encode_all : encoder -> unit

val remaining_drops_of_encoder : encoder -> Drop.t array

  type decode_error =
    [ `Invalid_drop_index
    | `Invalid_drop_size
    | `Cannot_recover
    ]

type decoder

val create_decoder : data_blocks:Cstruct.t array -> Param.t -> decoder

val reset_decoder : decoder -> unit

val param_of_decoder : decoder -> Param.t

val decoder_is_systematic : decoder -> bool

val data_block_count_of_decoder : decoder -> int

val max_drop_count_of_decoder : decoder -> int

val data_block_size_of_decoder : decoder -> int

val drop_fill_count_of_decoder : decoder -> int

val data_block_solved_count_of_decoder : decoder -> int

type decode_status =
  [ `Success
  | `Ongoing
  ]

val decode_one :
  decoder -> Drop.t -> (decode_status, decode_error) result * int list

val decode_all :
  decoder -> Drop.t list -> decode_error option * int list
