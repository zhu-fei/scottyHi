{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Web.Scotty
import GHC.Generics
import Data.Aeson(FromJSON, ToJSON)

data User = User {userId :: Int, userName :: String} deriving (Show, Generic)


instance ToJSON User
instance FromJSON User

allUsers :: [User]
allUsers = [bob, jenny]

bob = User { userId = 1, userName = "bob"}

jenny = User { userId = 2, userName = "jenny"}

matchesId id user = 
  userId user ==  id


main :: IO ()
main = do
  putStrLn "hello world"

  scotty 3000 $ do
    get "/hello" $ do
      text "hello world!"

    get "/users" $ do
      json allUsers

    get "/users/:id" $ do
      id <- param "id"
      json (filter (matchesId id) allUsers)




