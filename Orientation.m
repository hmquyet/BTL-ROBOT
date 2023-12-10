function O = Orientation(A)
 
 % Orientation
    O(1)  = atan2(A(2,3),A(3,3));  %roll
    O(2)  = asin(-A(3,1)); %pitch
    O(3)  = atan2(A(2,1),A(1,1));  %yaw
end