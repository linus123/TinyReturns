﻿using System;

namespace Dimensional.TinyReturns.Core.CitiFileImport
{
    public class CitiMonthlyReturnsDataFileRecord
    {
        public string ExternalId { get; set; }
        public string EndDate { get; set; }
        public string Value { get; set; }

        public int GetConvertedExternalId()
        {
            return Convert.ToInt32(ExternalId.Trim());
        }

        public int GetMonth()
        {
            return DateTime.Parse(EndDate).Month;
        }

        public int GetYear()
        {
            return DateTime.Parse(EndDate).Year;
        }

        public decimal GetDecimalValue()
        {
            return decimal.Parse(Value) / 100;
        }
    }
}