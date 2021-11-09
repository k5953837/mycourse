require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      user = create(:user, :with_admin)
      sign_in user
      create_list(:course, 5)
      get courses_url
      expect(response).to render_template('index')
    end

    it "redirect to '/' when user is not admin" do
      user = create(:user)
      sign_in user
      create_list(:course, 5)
      get courses_url
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = create(:user, :with_admin)
      sign_in user
      course = create(:course)
      get course_url(course)
      expect(response).to render_template('show')
    end

    it "redirect to '/' when user is not admin" do
      user = create(:user)
      sign_in user
      course = create(:course)
      get course_url(course)
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      user = create(:user, :with_admin)
      sign_in user
      get new_course_url
      expect(response).to render_template('new')
    end

    it "redirect to '/' when user is not admin" do
      user = create(:user)
      sign_in user
      get new_course_url
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      user = create(:user, :with_admin)
      sign_in user
      course = create(:course)
      get edit_course_url(course)
      expect(response).to render_template('edit')
    end

    it "redirect to '/' when user is not admin" do
      user = create(:user)
      sign_in user
      course = create(:course)
      get edit_course_url(course)
      expect(response).to redirect_to('/')
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Course and redirects to the created course' do
        user = create(:user, :with_admin)
        sign_in user
        expect do
          post courses_url, params: { course: attributes_for(:course) }
        end.to change(Course, :count).by(1)
        expect(response).to redirect_to(course_url(Course.last))
      end
    end

    context 'with invalid parameters' do
      let(:user) { create(:user, :with_admin) }

      before(:each) do
        sign_in user
      end

      context 'invalid category' do
        it 'category does not present' do
          expect do
            post courses_url, params: { course: attributes_for(:course, category: nil) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'category does not include in categories' do
          expect do
            post courses_url, params: { course: attributes_for(:course, category: 'invalid_category') }
          end.to raise_error("'invalid_category' is not a valid category")
        end
      end

      context 'invalid currency' do
        it 'currency does not present' do
          expect do
            post courses_url, params: { course: attributes_for(:course, currency: nil) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'currency does not include in categories' do
          expect do
            post courses_url, params: { course: attributes_for(:course, currency: 'invalid_currency') }
          end.to raise_error("'invalid_currency' is not a valid currency")
        end
      end

      context 'invalid status' do
        it 'status does not present' do
          expect do
            post courses_url, params: { course: attributes_for(:course, status: nil) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'status does not include in categories' do
          expect do
            post courses_url, params: { course: attributes_for(:course, status: 'invalid_status') }
          end.to raise_error("'invalid_status' is not a valid status")
        end
      end

      context 'invalid subject' do
        it 'subject does not present' do
          expect do
            post courses_url, params: { course: attributes_for(:course, subject: nil) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'invalid url' do
        it 'url does not present' do
          expect do
            post courses_url, params: { course: attributes_for(:course, url: nil) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'url does not valid' do
          expect do
            post courses_url, params: { course: attributes_for(:course, url: 'invalid_url') }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'invalid duration' do
        it 'duration does not present' do
          expect do
            post courses_url, params: { course: attributes_for(:course, duration: nil) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'duration does not valid (0)' do
          expect do
            post courses_url, params: { course: attributes_for(:course, duration: 0) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'duration does not valid (31)' do
          expect do
            post courses_url, params: { course: attributes_for(:course, duration: 31) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'invalid price' do
        it 'price does not present' do
          expect do
            post courses_url, params: { course: attributes_for(:course, price: nil) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'price does not valid (0)' do
          expect do
            post courses_url, params: { course: attributes_for(:course, price: 0) }
          end.to change(Course, :count).by(0)
          expect(response).to render_template('new')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'with invalid role' do
      it "redirect to '/' when user is not admin" do
        user = create(:user)
        sign_in user
        post courses_url, params: { course: attributes_for(:course) }
        expect(response).to redirect_to('/')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested course and redirects to the requested course' do
        user = create(:user, :with_admin)
        sign_in user
        course = create(:course)
        update_attributes = attributes_for(:course)
        patch course_url(course), params: { id: course.id, course: update_attributes }
        course.reload
        expect(course.subject).to eq(update_attributes[:subject])
        expect(course.price).to eq(update_attributes[:price])
        expect(course.currency).to eq(update_attributes[:currency])
        expect(course.category).to eq(update_attributes[:category])
        expect(course.status).to eq(update_attributes[:status])
        expect(course.url).to eq(update_attributes[:url])
        expect(course.description).to eq(update_attributes[:description])
        expect(course.duration).to eq(update_attributes[:duration])
        expect(response).to redirect_to(course_url(course))
      end
    end

    context 'with invalid parameters' do
      let(:user) { create(:user, :with_admin) }
      let(:course) { create(:course) }

      before(:each) do
        sign_in user
      end

      context 'invalid category' do
        it 'category does not present' do
          update_attributes = attributes_for(:course, category: nil)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'category does not include in categories' do
          update_attributes = attributes_for(:course, category: 'invalid_category')
          expect do
            patch course_url(course), params: { id: course.id, course: update_attributes }
          end.to raise_error("'invalid_category' is not a valid category")
        end
      end

      context 'invalid currency' do
        it 'currency does not present' do
          update_attributes = attributes_for(:course, currency: nil)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'currency does not include in categories' do
          update_attributes = attributes_for(:course, currency: 'invalid_currency')
          expect do
            patch course_url(course), params: { id: course.id, course: update_attributes }
          end.to raise_error("'invalid_currency' is not a valid currency")
        end
      end

      context 'invalid status' do
        it 'status does not present' do
          update_attributes = attributes_for(:course, status: nil)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'status does not include in categories' do
          update_attributes = attributes_for(:course, status: 'invalid_status')
          expect do
            patch course_url(course), params: { id: course.id, course: update_attributes }
          end.to raise_error("'invalid_status' is not a valid status")
        end
      end

      context 'invalid subject' do
        it 'subject does not present' do
          update_attributes = attributes_for(:course, subject: nil)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'invalid url' do
        it 'url does not present' do
          update_attributes = attributes_for(:course, url: nil)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'url does not valid' do
          update_attributes = attributes_for(:course, url: 'invalid_url')
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'invalid duration' do
        it 'duration does not present' do
          update_attributes = attributes_for(:course, duration: nil)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'duration does not valid (0)' do
          update_attributes = attributes_for(:course, duration: 0)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'duration does not valid (31)' do
          update_attributes = attributes_for(:course, duration: 31)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'invalid price' do
        it 'price does not present' do
          update_attributes = attributes_for(:course, price: nil)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'price does not valid (0)' do
          update_attributes = attributes_for(:course, price: 0)
          patch course_url(course), params: { id: course.id, course: update_attributes }
          expect(response).to render_template('edit')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'with invalid role' do
      it "redirect to '/' when user is not admin" do
        user = create(:user)
        sign_in user
        course = create(:course)
        update_attributes = attributes_for(:course)
        patch course_url(course), params: { id: course.id, course: update_attributes }
        expect(response).to redirect_to('/')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested course' do
      user = create(:user, :with_admin)
      sign_in user
      course = create(:course)
      expect do
        delete course_url(course)
      end.to change(Course, :count).by(-1)
      expect(response).to redirect_to(courses_url)
    end

    it "redirect to '/' when user is not admin" do
      user = create(:user)
      sign_in user
      course = create(:course)
      delete course_url(course)
      expect(response).to redirect_to('/')
    end
  end
end
