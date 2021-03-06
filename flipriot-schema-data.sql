PGDMP                          u            flipriot    9.5.4    9.6.1 8    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    17965    flipriot    DATABASE     z   CREATE DATABASE flipriot WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE flipriot;
             othersidedev    false                        2615    17966    Core    SCHEMA        CREATE SCHEMA "Core";
    DROP SCHEMA "Core";
             othersidedev    false            �           0    0    SCHEMA "Core"    COMMENT     E   COMMENT ON SCHEMA "Core" IS 'Primary Customer and Application Data';
                  othersidedev    false    11            
            2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             othersidedev    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  othersidedev    false    10            �           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM othersidedev;
GRANT ALL ON SCHEMA public TO othersidedev;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  othersidedev    false    10                        3079    13276    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    19344    ltree 	   EXTENSION     9   CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;
    DROP EXTENSION ltree;
                  false    10            �           0    0    EXTENSION ltree    COMMENT     Q   COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';
                       false    2                        3079    17978    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                  false    10            �           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                       false    3                        3079    17967 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                  false    10            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                       false    4            :           1247    19528    Enumeration_Account_Type    TYPE     b   CREATE TYPE "Enumeration_Account_Type" AS ENUM (
    'Social',
    'Creative',
    'Corporate'
);
 -   DROP TYPE "Core"."Enumeration_Account_Type";
       Core       othersidedev    false    11            �           0    0    TYPE "Enumeration_Account_Type"    COMMENT     _   COMMENT ON TYPE "Enumeration_Account_Type" IS 'Defines different types of customer accounts.';
            Core       othersidedev    false    1850            H           1247    19567    Enumeration_Media_Type    TYPE     e   CREATE TYPE "Enumeration_Media_Type" AS ENUM (
    'Image',
    'Video',
    'Audio',
    'Model'
);
 +   DROP TYPE "Core"."Enumeration_Media_Type";
       Core       othersidedev    false    11            A           1247    19544    Enumeration_User_Permission    TYPE     t   CREATE TYPE "Enumeration_User_Permission" AS ENUM (
    'Owner',
    'Administrator',
    'User',
    'ReadOnly'
);
 0   DROP TYPE "Core"."Enumeration_User_Permission";
       Core       othersidedev    false    11            �           0    0 "   TYPE "Enumeration_User_Permission"    COMMENT     m   COMMENT ON TYPE "Enumeration_User_Permission" IS 'Enumerated values defining permission level of the user.';
            Core       othersidedev    false    1857            �            1259    19535    Account    TABLE     �   CREATE TABLE "Account" (
    "Id" uuid NOT NULL,
    "Type" "Enumeration_Account_Type" NOT NULL,
    "CrmId" text,
    "Name" text NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "Modified" timestamp with time zone NOT NULL
);
    DROP TABLE "Core"."Account";
       Core         othersidedev    false    1850    11            �           0    0    TABLE "Account"    COMMENT     k   COMMENT ON TABLE "Account" IS 'This models the business relationship with an organization or individual.';
            Core       othersidedev    false    200            �            1259    19607    Effect    TABLE     �   CREATE TABLE "Effect" (
    "Id" uuid NOT NULL,
    "Media_Types" "Enumeration_Media_Type"[] NOT NULL,
    "Name" text NOT NULL,
    "Description" text NOT NULL
);
    DROP TABLE "Core"."Effect";
       Core         othersidedev    false    1864    11            �            1259    19623    InteractionDefinition    TABLE     6  CREATE TABLE "InteractionDefinition" (
    "Id" uuid NOT NULL,
    "Product_Id" uuid NOT NULL,
    "ConfigurationDefinition" json NOT NULL,
    "AssetTemplate" json NOT NULL,
    "Available" boolean NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "Modified" timestamp with time zone NOT NULL
);
 +   DROP TABLE "Core"."InteractionDefinition";
       Core         othersidedev    false    11            �            1259    19654    InteractionInstance    TABLE     �  CREATE TABLE "InteractionInstance" (
    "Id" uuid NOT NULL,
    "Account_Id" uuid NOT NULL,
    "InteractionDefinition_Id" uuid NOT NULL,
    "Target_Ids" uuid[] NOT NULL,
    "Configuration" json NOT NULL,
    "Assets" json NOT NULL,
    "Available" boolean NOT NULL,
    "Deleted" boolean NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "Modified" timestamp with time zone NOT NULL
);
 )   DROP TABLE "Core"."InteractionInstance";
       Core         othersidedev    false    11            �            1259    19575    Media    TABLE     ;  CREATE TABLE "Media" (
    "Id" uuid NOT NULL,
    "Account_Id" uuid NOT NULL,
    "Type" "Enumeration_Media_Type" NOT NULL,
    "Metadata" json NOT NULL,
    "AwsS3" text NOT NULL,
    "Deleted" boolean NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "Modified" timestamp with time zone NOT NULL
);
    DROP TABLE "Core"."Media";
       Core         othersidedev    false    11    1864            �           0    0    TABLE "Media"    COMMENT     �   COMMENT ON TABLE "Media" IS 'Stores metadata about media resources archived to the S3 repository, and thier usage within the system.';
            Core       othersidedev    false    202            �            1259    19615    Product    TABLE       CREATE TABLE "Product" (
    "Id" uuid NOT NULL,
    "Definition" json NOT NULL,
    "Available" boolean NOT NULL,
    "Name" text NOT NULL,
    "Description" text NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "Modified" timestamp with time zone NOT NULL
);
    DROP TABLE "Core"."Product";
       Core         othersidedev    false    11            �            1259    19589    Target    TABLE     T  CREATE TABLE "Target" (
    "Id" uuid NOT NULL,
    "Account_Id" uuid NOT NULL,
    "Media_Id" uuid NOT NULL,
    "Augmentability" bigint NOT NULL,
    "Provider_Vuforia_Id" text NOT NULL,
    "Provider_Vuforia_IsActive" boolean NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "Modified" timestamp with time zone NOT NULL
);
    DROP TABLE "Core"."Target";
       Core         othersidedev    false    11            �            1259    19553    User    TABLE     D  CREATE TABLE "User" (
    "Id" uuid NOT NULL,
    "Account_Id" uuid NOT NULL,
    "AwsCognito_Id" text NOT NULL,
    "Name" text NOT NULL,
    "Email" text NOT NULL,
    "Permission" "Enumeration_User_Permission" NOT NULL,
    "Created" timestamp with time zone NOT NULL,
    "Modified" timestamp with time zone NOT NULL
);
    DROP TABLE "Core"."User";
       Core         othersidedev    false    11    1857            �           0    0    TABLE "User"    COMMENT     q   COMMENT ON TABLE "User" IS 'User represents an account for an individual human to grant access to the service.';
            Core       othersidedev    false    201            �          0    19535    Account 
   TABLE DATA               R   COPY "Account" ("Id", "Type", "CrmId", "Name", "Created", "Modified") FROM stdin;
    Core       othersidedev    false    200   �A       �          0    19607    Effect 
   TABLE DATA               G   COPY "Effect" ("Id", "Media_Types", "Name", "Description") FROM stdin;
    Core       othersidedev    false    204   B       �          0    19623    InteractionDefinition 
   TABLE DATA               �   COPY "InteractionDefinition" ("Id", "Product_Id", "ConfigurationDefinition", "AssetTemplate", "Available", "Created", "Modified") FROM stdin;
    Core       othersidedev    false    206   7B       �          0    19654    InteractionInstance 
   TABLE DATA               �   COPY "InteractionInstance" ("Id", "Account_Id", "InteractionDefinition_Id", "Target_Ids", "Configuration", "Assets", "Available", "Deleted", "Created", "Modified") FROM stdin;
    Core       othersidedev    false    207   TB       �          0    19575    Media 
   TABLE DATA               m   COPY "Media" ("Id", "Account_Id", "Type", "Metadata", "AwsS3", "Deleted", "Created", "Modified") FROM stdin;
    Core       othersidedev    false    202   qB       �          0    19615    Product 
   TABLE DATA               k   COPY "Product" ("Id", "Definition", "Available", "Name", "Description", "Created", "Modified") FROM stdin;
    Core       othersidedev    false    205   �B       �          0    19589    Target 
   TABLE DATA               �   COPY "Target" ("Id", "Account_Id", "Media_Id", "Augmentability", "Provider_Vuforia_Id", "Provider_Vuforia_IsActive", "Created", "Modified") FROM stdin;
    Core       othersidedev    false    203   �B       �          0    19553    User 
   TABLE DATA               t   COPY "User" ("Id", "Account_Id", "AwsCognito_Id", "Name", "Email", "Permission", "Created", "Modified") FROM stdin;
    Core       othersidedev    false    201   �B       3          0    18268    spatial_ref_sys 
   TABLE DATA               "   COPY spatial_ref_sys  FROM stdin;
    public       rdsadmin    false    186   �B       5           2606    19539    Account Account_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY "Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY "Core"."Account" DROP CONSTRAINT "Account_pkey";
       Core         othersidedev    false    200    200            =           2606    19614    Effect Effect_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY "Effect"
    ADD CONSTRAINT "Effect_pkey" PRIMARY KEY ("Id");
 @   ALTER TABLE ONLY "Core"."Effect" DROP CONSTRAINT "Effect_pkey";
       Core         othersidedev    false    204    204            A           2606    19630 0   InteractionDefinition InteractionDefinition_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY "InteractionDefinition"
    ADD CONSTRAINT "InteractionDefinition_pkey" PRIMARY KEY ("Id");
 ^   ALTER TABLE ONLY "Core"."InteractionDefinition" DROP CONSTRAINT "InteractionDefinition_pkey";
       Core         othersidedev    false    206    206            C           2606    19661 ,   InteractionInstance InteractionInstance_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY "InteractionInstance"
    ADD CONSTRAINT "InteractionInstance_pkey" PRIMARY KEY ("Id");
 Z   ALTER TABLE ONLY "Core"."InteractionInstance" DROP CONSTRAINT "InteractionInstance_pkey";
       Core         othersidedev    false    207    207            9           2606    19582    Media Media_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY "Media"
    ADD CONSTRAINT "Media_pkey" PRIMARY KEY ("Id");
 >   ALTER TABLE ONLY "Core"."Media" DROP CONSTRAINT "Media_pkey";
       Core         othersidedev    false    202    202            ?           2606    19622    Product Product_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY "Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY "Core"."Product" DROP CONSTRAINT "Product_pkey";
       Core         othersidedev    false    205    205            ;           2606    19596    Target Target_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY "Target"
    ADD CONSTRAINT "Target_pkey" PRIMARY KEY ("Id");
 @   ALTER TABLE ONLY "Core"."Target" DROP CONSTRAINT "Target_pkey";
       Core         othersidedev    false    203    203            7           2606    19560    User User_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY "Core"."User" DROP CONSTRAINT "User_pkey";
       Core         othersidedev    false    201    201            D           2606    19561    User Account_Id FK Constraint    FK CONSTRAINT     }   ALTER TABLE ONLY "User"
    ADD CONSTRAINT "Account_Id FK Constraint" FOREIGN KEY ("Account_Id") REFERENCES "Account"("Id");
 K   ALTER TABLE ONLY "Core"."User" DROP CONSTRAINT "Account_Id FK Constraint";
       Core       othersidedev    false    201    4405    200            E           2606    19583    Media Account_Id FK Constraint    FK CONSTRAINT     ~   ALTER TABLE ONLY "Media"
    ADD CONSTRAINT "Account_Id FK Constraint" FOREIGN KEY ("Account_Id") REFERENCES "Account"("Id");
 L   ALTER TABLE ONLY "Core"."Media" DROP CONSTRAINT "Account_Id FK Constraint";
       Core       othersidedev    false    4405    202    200            F           2606    19597    Target Account_Id FK Constraint    FK CONSTRAINT        ALTER TABLE ONLY "Target"
    ADD CONSTRAINT "Account_Id FK Constraint" FOREIGN KEY ("Account_Id") REFERENCES "Account"("Id");
 M   ALTER TABLE ONLY "Core"."Target" DROP CONSTRAINT "Account_Id FK Constraint";
       Core       othersidedev    false    200    4405    203            I           2606    19662 ,   InteractionInstance Account_Id FK Constraint    FK CONSTRAINT     �   ALTER TABLE ONLY "InteractionInstance"
    ADD CONSTRAINT "Account_Id FK Constraint" FOREIGN KEY ("Account_Id") REFERENCES "Account"("Id");
 Z   ALTER TABLE ONLY "Core"."InteractionInstance" DROP CONSTRAINT "Account_Id FK Constraint";
       Core       othersidedev    false    200    4405    207            J           2606    19667 :   InteractionInstance InteractionDefinition_Id FK Constraint    FK CONSTRAINT     �   ALTER TABLE ONLY "InteractionInstance"
    ADD CONSTRAINT "InteractionDefinition_Id FK Constraint" FOREIGN KEY ("InteractionDefinition_Id") REFERENCES "InteractionDefinition"("Id");
 h   ALTER TABLE ONLY "Core"."InteractionInstance" DROP CONSTRAINT "InteractionDefinition_Id FK Constraint";
       Core       othersidedev    false    206    4417    207            G           2606    19602    Target Media_Id FK Constraint    FK CONSTRAINT     y   ALTER TABLE ONLY "Target"
    ADD CONSTRAINT "Media_Id FK Constraint" FOREIGN KEY ("Media_Id") REFERENCES "Media"("Id");
 K   ALTER TABLE ONLY "Core"."Target" DROP CONSTRAINT "Media_Id FK Constraint";
       Core       othersidedev    false    203    202    4409            H           2606    19631 .   InteractionDefinition Product_Id FK Constraint    FK CONSTRAINT     �   ALTER TABLE ONLY "InteractionDefinition"
    ADD CONSTRAINT "Product_Id FK Constraint" FOREIGN KEY ("Product_Id") REFERENCES "Product"("Id");
 \   ALTER TABLE ONLY "Core"."InteractionDefinition" DROP CONSTRAINT "Product_Id FK Constraint";
       Core       othersidedev    false    4415    206    205            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      3      x������ � �     