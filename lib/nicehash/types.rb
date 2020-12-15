require 'dry-struct'

module Nicehash
  module Types
    include Dry.Types()

    Uuid = Types::String.constrained(uuid_v4: true)
    Algorithms = Types::String.enum(
      *%w[
        SCRYPT SHA256 SCRYPTNF X11 X13 KECCAK X15 NIST5 NEOSCRYPT LYRA2RE
        WHIRLPOOLX QUBIT QUARK AXIOM LYRA2REV2 SCRYPTJANENF16 BLAKE256R8
        BLAKE256R14 BLAKE256R8VNL HODL DAGGERHASHIMOTO DECRED CRYPTONIGHT LBRY
        EQUIHASH PASCAL X11GOST SIA BLAKE2S SKUNK CRYPTONIGHTV7 CRYPTONIGHTHEAVY
        LYRA2Z X16R CRYPTONIGHTV8 SHA256ASICBOOST ZHASH BEAM GRINCUCKAROO29
        GRINCUCKATOO31 LYRA2REV3 CRYPTONIGHTR CUCKOOCYCLE GRINCUCKAROOD29 BEAMV2
        X16RV2 RANDOMXMONERO EAGLESONG CUCKAROOM GRINCUCKATOO32
       ]
    )
    Markets = Types::String.enum('EU', 'USA')
    OrderTypes = Types::String.enum('STANDARD' => 0, 'FIXED' => 1)
    OrderStates = Types::String.enum(
      *%w[
        Pending Active Pending_Cancellation Cancelled Dead Expired Error
        Error_On_Creation Error_On_Creation_On_Reverting_Transactions Completed
        Error_Missing
      ]
    )
    PositiveFloat = Types::Coercible::Float.constrained(gteq: 0.0)
    FloatString = Types.Constructor(Float) { |v| v.to_f }
    IntString = Types.Constructor(Integer) { |v| v.to_i }
    StringList = Types.Constructor(String) { |v| v.respond_to?(:join) ? v.join(',') : v }
    TimeInt = Types.Constructor(Time) { |v| ::Time.at(v.to_i / 1000) }
  end

  BaseStruct = Dry.Struct { transform_keys(&:to_sym) }

  class Deleted < BaseStruct
    attribute :success, Types::Bool
    attribute? :successType, Types::String.enum(
      'NOT_SUCCESSFUL', 'PARTIAL_SUCCESS', 'SUCCESSFUL'
    )
    attribute? :message, Types::String
  end
end
