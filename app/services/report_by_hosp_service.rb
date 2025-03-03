class ReportByHospService
  def initialize(hosp_id)
    @hosp_id = hosp_id
  end

  def call
    user_cids_groups
  end

  private

  attr_reader :hosp_id

  def user_cids_groups
    HospitalUserCid.select(user_cids: [ :cid_id ], cid: [ :number, :description ], hospital: [ :name ])
      .select('count(user_cids.id) AS size')
      .joins(:hospital, user_cid: :cid)
      .where(hospital_id: hosp_id)
      .group(user_cids: :cid_id, cid: [ :number, :description ], hospital: [ :name ])
      .order(cid_id: :asc)
  end
end
