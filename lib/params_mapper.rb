class ParamsMapper

  def initialize(params)
    @params = params
  end

  def execute
    map_params
  end

  private

  PARAMS_MAP = {
    :broker_id => :bid,
    :child_category_id => :ccatid,
    :city => :city,
    :event_inventory_id => :e,
    :end_date => :edate,
    :event_id => :evtid,
    :grandchild_category_id => :gcatid,
    :group_by => :grpby,
    :head => :head,
    :html => :html,
    :item => :item,
    :keywords => :kwds,
    :list => :list,
    :location => :location,
    :page_number => :pageNum,
    :parent_category_id => :pcatid,
    :performer_id => :pid,
    :results_type => :tid,
    :selected_events_id => :secid,
    :show_all => :showall,
    :show_categories => :showcats,
    :site_number => :sitenumber,
    :size => :size,
    :sort_column => :sortcol,
    :sort_order => :sortord,
    :start_date => :sdate,
    :state_or_province_id => :stprvid,
    :title => :title,
    :venue_id => :venid,
    :zip => :zip
  }

  def map_params
    h = Hash.new
    @params.map { |key, value|
      h.merge!({ PARAMS_MAP[key.to_sym] => value })
    }.first
  end

end