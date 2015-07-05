require 'JSON'
require 'nokogiri'
require_relative './nokogiri_to_hash'
require 'active_support/core_ext/hash'

class SearchSerializer

  def search_collection(view_payload)
    {
      collection: {
        version: "0.0.1",
        href: '/',
        view_code: [view_payload] #parse_payload(view_payload)
      },
      query_templates: query_templates,
      # style_sheet_classes: style_sheet_classes
    }.to_json
  end

  private

  def query_templates
    {
      general_results: {
        endpoint: "/search",
        required_params: {
          broker_id: "0000",
          site_number: "0",
          results_type: "general",
          keywords: "search string",
        },
        optional_params: {
          start_date: "01/30/16",
          end_date: "12/31/16",
          state_or_province_id: "00",
          zip: "AB 12345 or 80205",
          venue_id: "0000",
          city: "Denver",
          parent_category_id: "0000",
          child_category_id: "0000",
          grandchild_categroy_id: "0000"
        },
        sorting_params: {
          sort_column: "name of column - default: [date]",
          sort_order: "asc | desc - default: [asc]",
          show_all: "limit",
          page_number: "1",
          head: "true | false, if false, will not return descriptive blurb - default: [true]"
        }
      },
      ticket_results: {
        endpoint: "/tickets",
        required_params: {
          broker_id: "0000",
          site_number: "0",
          results_type: "tickets_2",
          event_id: "event_id usually provided by previous page"
        },
        sorting_params: {
          head: "true | false, if false, will not return descriptive blurb - default: [true]",
          html: "true | false [html or javascript] - default: [false]"
        }
      },
      venue_results: {
        endpoint: "/venue",
        required_params: {
          broker_id: "0000",
          site_number: "0",
          results_type: "venue",
          venue_id: "venue_id"
        },
        optional_params: {
          start_date: "01/30/16",
          end_date: "12/31/16",
          parent_category_id: "0000",
          child_category_id: "0000",
          grandchild_categroy_id: "0000"
        },
        sorting_params: {
          sort_column: "name of column - default: [date]",
          sort_order: "asc | desc - default: [asc]",
          show_all: "limit",
          page_number: "1",
          head: "true | false, if false, will not return descriptive blurb - default: [true]"
        }
      },
      location_results: {
        endpoint: "/location",
        required_params: {
          broker_id: "0000",
          site_number: "0",
          city: "Denver",
          state_or_province_id: "00",
          results_type: "location",
          location: "readable description of city/state/province to be used in title"
        },
        optional_params: {
          start_date: "01/30/16",
          end_date: "12/31/16",
          zip: "AB 12345 or 80205",
          venue_id: "venue_id",
          parent_category_id: "0000",
          child_category_id: "0000",
          grandchild_categroy_id: "0000"
        },
        sorting_params: {
          sort_column: "name of column - default: [date]",
          sort_order: "asc | desc - default: [asc]",
          show_all: "limit",
          page_number: "1",
          head: "true | false, if false, will not return descriptive blurb - default: [true]"
        }
      },
      date_results: {
        endpoint: "NotImplimented",
        required_params: {
          broker_id: "0000",
          site_number: "0",
          start_date: "01/30/16",
          end_date: "12/31/16",
          results_type: "date",
        },
        optional_params: {
          state_or_province_id: "00",
          zip: "AB 12345 or 80205",
          venue_id: "venue_id",
          city: "Denver",
          parent_category_id: "0000",
          child_category_id: "0000",
          grandchild_categroy_id: "0000"
        },
        sorting_params: {
          sort_column: "name of column - default: [date]",
          sort_order: "asc | desc - default: [asc]",
          show_all: "limit",
          page_number: "1",
          head: "true | false, if false, will not return descriptive blurb - default: [true]"
        }
      },
      event_names_results: {
        endpoint: "NotImplimented",
        required_params: {
          broker_id: "0000",
          site_number: "0",
          results_type: "event_names",
          parent_category_id: "0000",
          child_category_id: "0000",
          grandchild_categroy_id: "0000",
          title: "title to show at top of plugin"
        },
        optional_params: {
          show_categories: "true | false - default: [false]",
          group_by: "city | [empty/blank] - default: [empty/blank]",
          start_date: "01/30/16",
          end_date: "12/31/16",
          zip: "AB 12345 or 80205",
          state_or_province_id: "00",
          venue_id: "venue_id",
          city: "Denver"
        }
      },
      category_results: {
        endpoint: "NotImplimented",
        ### DO THESE
      },
      zip_results: {
        endpoint: "NotImplimented",
        ### DO THESE
      }
    }
  end

  def style_sheet_classes
    {
      ##style sheets
    }
  end

  def parse_payload(view_payload)
    Nokogiri::HTML(view_payload).to_hash
  end

end