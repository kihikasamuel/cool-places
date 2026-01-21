defmodule CoolPlaces.NewslettersTest do
  use CoolPlaces.DataCase

  alias CoolPlaces.Newsletters

  describe "newsletters" do
    alias CoolPlaces.Newsletters.Newsletter

    import CoolPlaces.NewslettersFixtures

    @invalid_attrs %{}

    test "list_newsletters/0 returns all newsletters" do
      newsletter = newsletter_fixture()
      assert Newsletters.list_newsletters() == [newsletter]
    end

    test "get_newsletter!/1 returns the newsletter with given id" do
      newsletter = newsletter_fixture()
      assert Newsletters.get_newsletter!(newsletter.id) == newsletter
    end

    test "create_newsletter/1 with valid data creates a newsletter" do
      valid_attrs = %{}

      assert {:ok, %Newsletter{} = newsletter} = Newsletters.create_newsletter(valid_attrs)
    end

    test "create_newsletter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Newsletters.create_newsletter(@invalid_attrs)
    end

    test "update_newsletter/2 with valid data updates the newsletter" do
      newsletter = newsletter_fixture()
      update_attrs = %{}

      assert {:ok, %Newsletter{} = newsletter} = Newsletters.update_newsletter(newsletter, update_attrs)
    end

    test "update_newsletter/2 with invalid data returns error changeset" do
      newsletter = newsletter_fixture()
      assert {:error, %Ecto.Changeset{}} = Newsletters.update_newsletter(newsletter, @invalid_attrs)
      assert newsletter == Newsletters.get_newsletter!(newsletter.id)
    end

    test "delete_newsletter/1 deletes the newsletter" do
      newsletter = newsletter_fixture()
      assert {:ok, %Newsletter{}} = Newsletters.delete_newsletter(newsletter)
      assert_raise Ecto.NoResultsError, fn -> Newsletters.get_newsletter!(newsletter.id) end
    end

    test "change_newsletter/1 returns a newsletter changeset" do
      newsletter = newsletter_fixture()
      assert %Ecto.Changeset{} = Newsletters.change_newsletter(newsletter)
    end
  end

  describe "subscription" do
    alias CoolPlaces.Newsletters.Subscription

    import CoolPlaces.NewslettersFixtures

    @invalid_attrs %{}

    test "list_subscription/0 returns all subscription" do
      subscription = subscription_fixture()
      assert Newsletters.list_subscription() == [subscription]
    end

    test "get_subscription!/1 returns the subscription with given id" do
      subscription = subscription_fixture()
      assert Newsletters.get_subscription!(subscription.id) == subscription
    end

    test "create_subscription/1 with valid data creates a subscription" do
      valid_attrs = %{}

      assert {:ok, %Subscription{} = subscription} = Newsletters.create_subscription(valid_attrs)
    end

    test "create_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Newsletters.create_subscription(@invalid_attrs)
    end

    test "update_subscription/2 with valid data updates the subscription" do
      subscription = subscription_fixture()
      update_attrs = %{}

      assert {:ok, %Subscription{} = subscription} = Newsletters.update_subscription(subscription, update_attrs)
    end

    test "update_subscription/2 with invalid data returns error changeset" do
      subscription = subscription_fixture()
      assert {:error, %Ecto.Changeset{}} = Newsletters.update_subscription(subscription, @invalid_attrs)
      assert subscription == Newsletters.get_subscription!(subscription.id)
    end

    test "delete_subscription/1 deletes the subscription" do
      subscription = subscription_fixture()
      assert {:ok, %Subscription{}} = Newsletters.delete_subscription(subscription)
      assert_raise Ecto.NoResultsError, fn -> Newsletters.get_subscription!(subscription.id) end
    end

    test "change_subscription/1 returns a subscription changeset" do
      subscription = subscription_fixture()
      assert %Ecto.Changeset{} = Newsletters.change_subscription(subscription)
    end
  end
end
