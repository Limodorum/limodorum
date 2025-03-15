module Types

    using Dates

    struct Attribute{T}
        id::Int
        scale::T
        rawvalue::String
        interpretedvalue::String
        certainty::UInt8
    end

    struct Scale
        id::Int
        displayname::String
        description::String
        allowedvalues::AbstractVector
    end

    struct Geography
    end

    struct LocationAttributeScale
        id::Int
        displayname::String
        description::String
        allowedvalues::AbstractVector
    end

        struct LocationAttribute
            id::Int
            scale::LocationAttributeScale
            rawvalue::String
            interpretedvalue::String
            certainty::UInt8
        end

            struct Location
                id::Int
                displayname::String
                geometry::Geography
                precision::AbstractFloat
                attributes::LocationAttribute
            end

                struct LocationGroup
                    id::Int
                    description::String
                    location::Location
                end

    struct Occurence
    end

    struct SurveyAttributeScale
    end

        struct SurveyAttribute
            id::Int
            scale::SurveyAttributeScale
            rawvalue::String
            interpretedvalue::String
            certainty::UInt8
        end

            struct Survey
                id::Int
                displayname::String
                date::Date
                location::Location
                attributes::SurveyAttribute
            end

    struct Taxon
    end

end