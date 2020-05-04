Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05131C34F9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 10:53:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD1C311509E3C;
	Mon,  4 May 2020 01:51:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D635B11509E3A
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 01:51:37 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0448hGEr076213;
	Mon, 4 May 2020 04:53:08 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30s4gtk65s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2020 04:53:08 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0448osbo004705;
	Mon, 4 May 2020 08:53:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04fra.de.ibm.com with ESMTP id 30s0g61rqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2020 08:53:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0448psXc66191812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2020 08:51:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7157C11C04A;
	Mon,  4 May 2020 08:53:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B80011C04C;
	Mon,  4 May 2020 08:53:00 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.222])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon,  4 May 2020 08:53:00 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 04 May 2020 14:22:58 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH v6 1/4] powerpc: Document details on H_SCM_HEALTH hcall
In-Reply-To: <87r1w5echa.fsf@mpe.ellerman.id.au>
References: <20200420070711.223545-1-vaibhav@linux.ibm.com> <20200420070711.223545-2-vaibhav@linux.ibm.com> <87r1w5echa.fsf@mpe.ellerman.id.au>
Date: Mon, 04 May 2020 14:22:58 +0530
Message-ID: <87bln4dqtx.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_04:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=7 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040069
Message-ID-Hash: RBY3VESLS3AOJFKFU6SBCE77JDVITHNE
X-Message-ID-Hash: RBY3VESLS3AOJFKFU6SBCE77JDVITHNE
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RBY3VESLS3AOJFKFU6SBCE77JDVITHNE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for looking into this patch Mpe,

Michael Ellerman <mpe@ellerman.id.au> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
>> Add documentation to 'papr_hcalls.rst' describing the bitmap flags
>> that are returned from H_SCM_HEALTH hcall as per the PAPR-SCM
>> specification.
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>>
>> v5..v6
>> * New patch in the series
>> ---
>>  Documentation/powerpc/papr_hcalls.rst | 43 ++++++++++++++++++++++++---
>>  1 file changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
>> index 3493631a60f8..9a5ba5eaf323 100644
>> --- a/Documentation/powerpc/papr_hcalls.rst
>> +++ b/Documentation/powerpc/papr_hcalls.rst
>> @@ -220,13 +220,48 @@ from the LPAR memory.
>>  **H_SCM_HEALTH**
>>  
>>  | Input: drcIndex
>> -| Out: *health-bitmap, health-bit-valid-bitmap*
>> +| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
>>  | Return Value: *H_Success, H_Parameter, H_Hardware*
>>  
>>  Given a DRC Index return the info on predictive failure and overall health of
>> -the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
>> -failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
>> -valid.
>> +the NVDIMM. The asserted bits in the health-bitmap indicate one or more states
>> +(described in table below) of the NVDIMM and health-bit-valid-bitmap indicate
>> +which bits in health-bitmap are valid.
>> +
>> +Health Bitmap Flags:
>> +
>> ++------+-----------------------------------------------------------------------+
>> +|  Bit |               Definition                                              |
>> ++======+=======================================================================+
>> +|  00  | SCM device is unable to persist memory contents.                      |
>> +|      | If the system is powered down, nothing will be saved.                 |
>> ++------+-----------------------------------------------------------------------+
>
> Are these correct bit numbers or backward IBM big endian bit numbers?
>
> ie. which bit is LSB?
These bit numbers index to a 64-bit dword laid in IBM big endian
format. So LSB would be at the located at a higher address. For example
0xC400000000000000 indicates bits 0, 1, and 5 are valid.

>
> cheers
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
