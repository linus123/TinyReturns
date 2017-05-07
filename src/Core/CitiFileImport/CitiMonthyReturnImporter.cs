﻿using System;
using System.Collections.Generic;
using System.Linq;
using Dimensional.TinyReturns.Core.TinyReturnsDatabase.Performance;

namespace Dimensional.TinyReturns.Core.CitiFileImport
{
    public class CitiMonthyReturnImporter
    {
        private readonly IReturnSeriesDataTableGateway _returnSeriesDataTableGateway;
        private readonly ICitiReturnsFileReader _citiReturnsFileReader;

        public CitiMonthyReturnImporter(
            ICitiReturnsFileReader citiReturnsFileReader,
            IReturnSeriesDataTableGateway returnSeriesDataTableGateway)
        {
            _citiReturnsFileReader = citiReturnsFileReader;
            _returnSeriesDataTableGateway = returnSeriesDataTableGateway;
        }

        public void ImportMonthyPortfolioNetReturnsFile(
            string filePath)
        {
            var citiMonthlyReturnsDataFileRecords = _citiReturnsFileReader.ReadFile(filePath);

            var returnSeriesDtos = new List<ReturnSeriesDto>();

            foreach (var citiMonthlyReturnsDataFileRecord in citiMonthlyReturnsDataFileRecords)
            {
                var portfolioNumber = citiMonthlyReturnsDataFileRecord.GetPortfolioNumber();

                var returnSeriesName = CreateReturnSeriesName(portfolioNumber);

                var returnSeriesDto = returnSeriesDtos.FirstOrDefault(d => d.Name == returnSeriesName);

                if (returnSeriesDto == null)
                {
                    returnSeriesDto = CreateAndInsertReturnSeriesDto(returnSeriesName);

                    returnSeriesDtos.Add(returnSeriesDto);
                }
            }
        }

        private ReturnSeriesDto CreateAndInsertReturnSeriesDto(
            string returnSeriesName)
        {
            var returnSeriesDto = new ReturnSeriesDto()
            {
                Name = returnSeriesName,
                Disclosure = String.Empty
            };

            var returnSeriesId = _returnSeriesDataTableGateway.Insert(returnSeriesDto);

            returnSeriesDto.ReturnSeriesId = returnSeriesId;

            return returnSeriesDto;
        }

        public static string CreateReturnSeriesName(int portfolioNumber)
        {
            return string.Format("Return Series for Portfolio Number {0}", portfolioNumber);
        }
    }
}