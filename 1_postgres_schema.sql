create table users (
  registered_at timestamp default now() not null,
  uid text not null primary key,
  username text not null,
  mobile_number text,
  email_id text,
  name text not null,
  bio text,
  address text,
  dob date default now(),
  profile_picture text,
  is_portfolio boolean,
  portfolio_status text,
  portfolio_description text,
  is_banned boolean,
  is_spam boolean,
  is_deactivated boolean not null,
  portfolio_created_at timestamp default now(),
  portfolio_title text,
  total_followers bigint,
  total_followings bigint not null,
  total_post_likes bigint,
  gender text,
  is_online boolean not null,
  last_active_at timestamp default now(),
  user_last_lat_long_wkb extensions.geography,
  total_connections bigint,
  total_likes bigint,
  public_email_id text,
  seo_data_weighted tsvector
);

create table private_chats (
  uid uuid default uuid_generate_v4() primary key,
  user1_uid text references users (uid),
  user2_uid text references users (uid),
  created_at timestamp default now() not null,
  last_message_at timestamp default now(),
  user1_is_muted boolean,
  user2_is_muted boolean,
  user1_is_blocked boolean,
  user2_is_blocked boolean,
  plain_last_message text
);

create table premium_user_names (
  id bigint not null primary key,
  created_at timestamp default now() not null,
  user_uid text references users (uid),
  expiry_date timestamp default now(),
  user_name text not null,
  post_user_name text
);

create table work_experiences (
  id bigint not null primary key,
  created_at timestamp default now() not null,
  designation text not null,
  start_date date default now(),
  end_date date default now(),
  user_uid text references users (uid),
  working_mode text,
  is_currently_working boolean,
  company_name text
);

create table user_agents (
  created_at timestamp default now() not null,
  fcm_token text,
  agent_type text,
  user_uid text references users (uid),
  ip_address inet,
  uid uuid default uuid_generate_v4() primary key,
  is_active boolean,
  agent_id text,
  agent_name text,
  app_version_code bigint
);

create table communities (
  created_at timestamp default now() not null,
  admin_user_uid text references users (uid),
  status text not null,
  bio text,
  location text,
  description text,
  title text,
  profile_picture text,
  uid uuid default uuid_generate_v4() primary key,
  username text not null,
  total_members bigint,
  require_joining_approval boolean,
  seo_data_weighted tsvector,
  plain_last_message text,
  last_message_at timestamp default now()
);

create table profile_pictures (
  id bigint not null primary key,
  created_at timestamp default now() not null,
  url text not null,
  user_uid text references users (uid),
  community_uid uuid references communities (uid)
);

create table photos (
  created_at timestamp default now() not null,
  uid uuid default uuid_generate_v4() primary key,
  title text not null,
  description text,
  hashtags text[],
  tagged_user_uids text[],
  is_deleted boolean,
  is_archived boolean,
  is_active boolean,
  post_creator_type public.post_creator_type not null,
  updated_at timestamp default now(),
  user_uid text references users (uid),
  location text,
  total_impressions bigint,
  total_likes bigint,
  total_comments bigint,
  internal_ai_description text,
  address_lat_long_wkb extensions.geography,
  creator_lat_long_wkb extensions.geography,
  tagged_community_uids text[],
  total_shares bigint,
  cumulative_score numeric,
  files_data jsonb,
  seo_data_weighted tsvector,
  community_uid uuid references communities (uid)
);

create table community_members (
  community_uid uuid references communities (uid) primary key,
  user_uid text references users (uid) primary key,
  joined_at timestamp default now() not null,
  role text not null,
  status text not null,
  approved boolean not null,
  invited_by_user_uid text references users (uid),
  last_active_at timestamp default now(),
  muted_until timestamp default now(),
  join_request_message text,
  notes text
);

create table cover_media (
  id bigint not null primary key,
  created_at timestamp default now() not null,
  image_url text not null,
  is_video boolean not null,
  user_uid text references users (uid),
  video_url text,
  community_uid uuid references communities (uid)
);

create table test54 (
  id bigint not null primary key,
  created_at timestamp default now() not null,
  uid uuid default uuid_generate_v4() primary key
);

create table flicks (
  created_at timestamp default now() not null,
  uid uuid default uuid_generate_v4() primary key,
  title text not null,
  description text,
  hashtags text[],
  tagged_user_uids text[],
  is_deleted boolean,
  is_archived boolean,
  is_active boolean,
  post_creator_type public.post_creator_type not null,
  updated_at timestamp default now(),
  user_uid text references users (uid),
  thumbnail text,
  video_url text not null,
  location text,
  total_views bigint,
  total_likes bigint,
  total_comments bigint,
  internal_ai_description text,
  address_lat_long_wkb extensions.geography,
  creator_lat_long_wkb extensions.geography,
  tagged_community_uids text[],
  total_shares bigint,
  cumulative_score numeric,
  video_duration_in_sec bigint,
  seo_data_weighted tsvector,
  community_uid uuid references communities (uid)
);

create table pdfs (
  created_at timestamp default now() not null,
  file_url text not null,
  user_uid text references users (uid),
  title text not null,
  thumbnail_url text not null,
  description text,
  post_creator_type public.post_creator_type not null,
  creator_lat_long_wkb extensions.geography,
  uid uuid default uuid_generate_v4() primary key,
  seo_data_weighted tsvector,
  community_uid uuid references communities (uid)
);

create table offers (
  created_at timestamp default now() not null,
  uid uuid default uuid_generate_v4() primary key,
  title text,
  description text not null,
  hashtags text[],
  tagged_user_uids text[],
  is_deleted boolean,
  is_archived boolean,
  is_active boolean,
  post_creator_type public.post_creator_type not null,
  user_uid text references users (uid),
  total_impressions bigint,
  total_likes bigint,
  total_comments bigint,
  internal_ai_description text,
  creator_lat_long_wkb extensions.geography,
  tagged_community_uids text[],
  total_shares bigint,
  cumulative_score numeric,
  cta_action text,
  cta_action_url text,
  files_data jsonb,
  status text not null,
  target_gender text,
  target_areas text[],
  seo_data_weighted tsvector,
  community_uid uuid references communities (uid)
);

create table wtvs (
  created_at timestamp default now() not null,
  uid uuid default uuid_generate_v4() primary key,
  title text not null,
  description text,
  hashtags text[],
  tagged_user_uids text[],
  is_deleted boolean,
  is_archived boolean,
  is_active boolean,
  post_creator_type public.post_creator_type not null,
  updated_at timestamp default now(),
  user_uid text references users (uid),
  thumbnail text,
  video_url text not null,
  location text,
  total_views bigint,
  total_likes bigint,
  total_comments bigint,
  internal_ai_description text,
  address_lat_long_wkb extensions.geography,
  creator_lat_long_wkb extensions.geography,
  tagged_community_uids text[],
  total_shares bigint,
  cumulative_score numeric,
  video_duration_in_sec bigint,
  seo_data_weighted tsvector,
  community_uid uuid references communities (uid)
);

create table users_relation (
  uid uuid default uuid_generate_v4() primary key,
  created_at timestamp default now() not null,
  follower_user_uid text references users (uid),
  followee_user_uid text references users (uid),
  is_muted boolean,
  is_favorite boolean,
  notifications_enabled boolean
);

create table memories (
  created_at timestamp default now() not null,
  uid uuid default uuid_generate_v4() primary key,
  caption text,
  hashtags text[],
  tagged_user_uids text[],
  is_deleted boolean,
  is_archived boolean,
  is_active boolean,
  post_creator_type public.post_creator_type not null,
  expires_at timestamp default now(),
  user_uid text references users (uid),
  image_url text,
  video_url text,
  is_video boolean,
  location text,
  total_views bigint,
  total_likes bigint,
  total_comments bigint,
  internal_ai_description text,
  address_lat_long_wkb extensions.geography,
  creator_lat_long_wkb extensions.geography,
  tagged_community_uids text[],
  total_shares bigint,
  cumulative_score numeric,
  cta_action text,
  cta_action_url text,
  is_image boolean,
  is_text boolean,
  video_duration_ms bigint,
  seo_data_weighted tsvector,
  community_uid uuid references communities (uid)
);

create table chat_messages (
  uid uuid default uuid_generate_v4() primary key,
  sender_uid text references users (uid),
  message text not null,
  created_at timestamp default now() not null,
  is_pinned boolean,
  community_uid uuid references communities (uid),
  private_chat_uid uuid references private_chats (uid),
  flick_uid uuid references flicks (uid),
  memory_uid uuid references memories (uid),
  offer_uid uuid references offers (uid),
  photo_post_uid uuid references photos (uid),
  video_post_uid uuid references wtvs (uid),
  pdf_uid uuid references pdfs (uid),
  reply_to_message_uid uuid references chat_messages (uid),
  forwarder_user_uid text references users (uid),
  is_deleted boolean,
  is_system_message boolean
);

create table tracked_activities (
  uid uuid default uuid_generate_v4() primary key,
  user_uid text references users (uid),
  video_post_uid uuid references wtvs (uid),
  flick_post_uid uuid references flicks (uid),
  photo_post_uid uuid references photos (uid),
  offer_uid uuid references offers (uid),
  memory_uid uuid references memories (uid),
  pdf_uid uuid references pdfs (uid),
  activity_timestamp timestamp default now(),
  created_at timestamp default now(),
  device_os text,
  device_model text,
  geo_location extensions.geography(Point,4326),
  app_version text,
  activity_type text
);

create table user_comments (
  created_at timestamp default now() not null,
  comment_text text not null,
  user_uid text references users (uid),
  video_post_uid uuid references wtvs (uid),
  flick_post_uid uuid references flicks (uid),
  memory_uid uuid references memories (uid),
  offer_post_uid uuid references offers (uid),
  photo_post_uid uuid references photos (uid),
  pdf_uid uuid references pdfs (uid),
  uid text not null primary key,
  image_url text
);

create table educations (
  id bigint not null primary key,
  created_at timestamp default now() not null,
  user_uid text references users (uid),
  title text not null,
  start_date date default now(),
  end_date date default now(),
  type text not null,
  institute text,
  is_ongoing_education boolean
);

create table services (
  id bigint not null primary key,
  created_at timestamp default now() not null,
  title text not null,
  user_uid text references users (uid),
  description text not null,
  community_uid uuid references communities (uid)
);

create table user_comment_replies (
  created_at timestamp default now() not null,
  reply_text text not null,
  user_uid text references users (uid),
  uid uuid default uuid_generate_v4() primary key,
  comment_uid text references user_comments (uid)
);

create table tag_registry (
  tagged_at timestamp default now() not null,
  tagged_user_uid text references users (uid),
  tagged_community_uid uuid references communities (uid),
  wtv_uid uuid references wtvs (uid),
  flick_uid uuid references flicks (uid),
  photo_uid uuid references photos (uid),
  offer_uid uuid references offers (uid),
  pdf_uid uuid references pdfs (uid),
  tagged_by_user_uid text references users (uid),
  uid uuid default uuid_generate_v4() primary key
);

create table user_reactions (
  created_at timestamp default now() not null,
  user_uid text references users (uid),
  video_post_uid uuid references wtvs (uid),
  flick_post_uid uuid references flicks (uid),
  memory_uid uuid references memories (uid),
  offer_post_uid uuid references offers (uid),
  photo_post_uid uuid references photos (uid),
  pdf_uid uuid references pdfs (uid),
  uid text not null primary key,
  reaction_type text not null
);

