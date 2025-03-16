module Types

    using Dates


    abstract type Json <: Any end

    abstract type Geography <:String end

    abstract type Identified end
    id(a::Identified) = a.id

    abstract type Displaynamed <: Identified end
    displayname(a::Displaynamed) = a.displayname

    abstract type Attribute <: Identified end
    scale(a::Attribute) = a.scale

    abstract type AttributeRawValue <: Attribute end
    rawvalue(a::AttributeRawValue) = a.rawvalue
    interpretedvalue(a::AttributeRawValue) = a.interpretedvalue
    certainty(a::AttributeRawValue) = a.certainty

    abstract type AttributeScale <: Displaynamed end
    description(a::AttributeScale) = a.description
    allowedvalues(a::AttributeScale) = a.allowedvalues


    struct LocationAttributeScale <: AttributeScale
        id::Int
        displayname::String
        description::String
        allowedvalues::Json
    end

        struct LocationAttribute <: AttributeRawValue
            id::Int
            scale::LocationAttributeScale
            rawvalue::String
            interpretedvalue::String
            certainty::UInt8
        end
        rawvalue

            struct Location <: Displaynamed
                id::Int
                displayname::String
                geometry::Geography
                precision::AbstractFloat
                attributes::LocationAttribute
            end
            geometry(a::Location) = a.geometry
            precision(a::Location) = a.precision
            attributes(a::Location) = a.attributes


                struct LocationGroup <: Identified
                    id::Int
                    description::String
                    location::Location
                end
                description(a::LocationGroup) = a.description
                location(a::LocationGroup) = a.location

    struct Taxon <: Displaynamed
        id::Int
        rank::Int
        parenttaxon::Taxon
        displayname::String
        shortdisplayname::String
        name::String
    end
    rank(a::Taxon) = a.rank
    parenttaxon(a::Taxon) = a.parenttaxon
    shortdisplayname(a::Taxon) = a.shortdisplayname
    name(a::Taxon) = a.name

        struct TaxonAttributeScale <: AttributeScale
            id::Int
            displayname::String
            description::String
            allowedvalues::Json
        end

            struct TaxonAttribute <: Attribute
                id::Int
                scale::TaxonAttributeScale
                taxon::Taxon
                value::Json
            end
            taxon(a::TaxonAttribute) = a.taxon
            value(a::TaxonAttribute) = a.value

        struct TaxonOccurence <: Identified
            id::Int
            taxon::Taxon
            certainty::UInt8
        end
        taxon(a::TaxonOccurence) = a.taxon
        certainty(a::TaxonOccurence) = a.certainty

    struct OccurenceAttributeScale <: AttributeScale
        id::Int
        displayname::String
        description::String
        allowedvalues::Json
    end

        struct OccurenceAttribute <: AttributeRawValue
            id::Int
            scale::OccurenceAttributeScale
            taxon::Taxon
            rawvalue::String
            interpretedvalue::Json
            certainty::UInt8
        end
        taxon(a::OccurenceAttribute) = a.taxon

    struct SurveyAttributeScale <: AttributeScale
        id::Int
        displayname::String
        description::String
        allowedvalues::Json
    end

        struct SurveyAttribute <: AttributeRawValue
            id::Int
            scale::SurveyAttributeScale
            rawvalue::String
            interpretedvalue::String
            certainty::UInt8
        end

            struct Survey <: Displaynamed
                id::Int
                displayname::String
                date::Date
                location::Location
                attributes::SurveyAttribute
            end
            date(a::Survey) = a.date
            location(a::Survey) = a.location
            attributes(a::Survey) = a.attributes

                struct Occurence <: Identified
                    id::Int
                    survey::Survey
                    rawspecies::String
                    taxons::TaxonOccurence
                    attributes::OccurenceAttribute
                end
                survey(a::Occurence) = a.survey
                rawspecies(a::Occurence) = a.rawspecies
                taxons(a::Occurence) = a.taxons
                attributes(a::Occurence) = a.attributes

end