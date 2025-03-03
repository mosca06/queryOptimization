class ReportByUserService
  def initialize(user_id)
    @user_id = user_id
  end

  def call
    user_ordered_cids
  end

  private

  attr_reader :user_id

  def user_ordered_cids
    # Quando não tem a associação definida na model precisa especificar o "joins" na query assim:
    # UserCid.joins(:cid, hospital_user_cids: :hospital).where(user_id: user_id)

    UserCid.select(cids: [ :number, :description ], hospitals: [ :name ])
           .joins(:cid, hospital_user_cids: :hospital)
           .where(user_id: user_id)
           .order(user_id: :desc)
  end
end
