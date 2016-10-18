require "graphql/object_type"

module Graph
  PhoneNumberType = GraphQL::ObjectType.define do
    name "PhoneNumber"
    description "An E164 validated phone number"

    field :e164_format, !types.String, "Internationally recognized E164 format, no formatting. Example: +19179032036"

    field :international_format, !types.String, "The local country format with country code. Example: +1 917 903 2036"

    field :national_format, !types.String, "The local country format without country code. Example: (917) 903-2036"

    field :number_type, !types.String, "Mobile, landline etc"

    field :valid, !types.Boolean do
      description "Validity of the number by format"

      resolve -> (phone_number_wrapper, args, ctx) do
        phone_number_wrapper.valid?
      end
    end

    field :carrier, types.String, <<~TEXT
      Offline attempt to identify the carrier.

      This seems to work well except for numbers that have been ported to other carriers.
    TEXT
  end
end
