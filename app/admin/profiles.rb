ActiveAdmin.register Profile do
  scope :approved
  permit_params :user_id, :bio, :total_hours, :location, :available_hours

  index do
    column :id
    column :user do |profile|
      profile.user.name
    end
    column :bio
    column :total_hours
    column :location
    column :available_hours
    column :approved do |profile|
      profile.user.approved
    end
    column :skills do |profile|
      profile.skills.pluck(:skill).join(',')
    end
    actions
  end

  member_action :approve, method: :put do
    resource.user.update(approved: true)
    redirect_to admin_profile_path(resource), notice: 'approved'
  end
end
