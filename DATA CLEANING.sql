select *
from Nashvillehousing

select newdate, CONVERT(date,SaleDate)
from Nashvillehousing

alter table Nashvillehousing
add newdate date;

update Nashvillehousing
set newdate = CONVERT(date,SaleDate)


select *
from Nashvillehousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from Nashvillehousing a
join Nashvillehousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from Nashvillehousing a
join Nashvillehousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select PropertyAddress
from Nashvillehousing
----where PropertyAddress is null
--order by ParcelID

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as address
from Nashvillehousing

select distinct (SoldAsVacant), COUNT(SoldAsVacant)
from Nashvillehousing
group by SoldAsVacant
order by 2

select SoldAsVacant
, case when SoldAsVacant = 'Y' THEN 'Yes'
 when SoldAsVacant = 'N' THEN 'No'
else SoldAsVacant
end
from Nashvillehousing

update Nashvillehousing
set SoldAsVacant= case when SoldAsVacant = 'Y' THEN 'Yes'
 when SoldAsVacant = 'N' THEN 'No'
else SoldAsVacant
end

WITH RowNumCTE AS (
select*,
ROW_NUMBER() over (
partition by ParcelID,
PropertyAddress,
SalePrice,
SaleDate,
LegalReference
order by 
UniqueID
) row_num
from Nashvillehousing
--order by ParcelID
)
delete
from RowNumCTE
WHERE row_num > 1
--order by PropertyAddress

select*
from Nashvillehousing

alter table Nashvillehousing
drop column owneraddress,taxdistrict, propertyaddress

alter table Nashvillehousing
drop column saledate

