module ApiV1
  class PurchaseCourse < Grape::API
    desc 'End-points for the PurchaseCourse'
    namespace :purchase_course do
      desc 'Purchase online course'
      params do
        requires :course_id, type: Integer, desc: 'course_id'
      end
      post do
        # Authenticate user
        authenticate!

        # Check if course is offline?
        course = Course.find(params[:course_id])
        raise OfflineCourse if course.offline?

        # Check if course is available for user
        order = current_user.orders.available.find_by(subject: course.subject)
        raise ExistAvailableCourse if order.present?

        # Create order for user
        order = current_user.orders.create(
          subject: course.subject,
          category: course.category,
          snapshot: course.as_json.slice('subject', 'price', 'currency', 'category', 'url', 'description', 'duration')
        )

        # Return order
        status 200
        present order, with: ApiV1::Entities::Order
      end
    end
  end
end
