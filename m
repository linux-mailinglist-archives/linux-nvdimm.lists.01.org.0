Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D37A9942
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 06:10:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F73121962301;
	Wed,  4 Sep 2019 21:11:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4816921962301
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 21:11:52 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8547Qds099320; Thu, 5 Sep 2019 00:10:47 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uttnt1072-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 00:10:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8549uPb028987;
 Thu, 5 Sep 2019 04:10:46 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01dal.us.ibm.com with ESMTP id 2uqgh7dq5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 04:10:46 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x854AjNw26739194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Sep 2019 04:10:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AD70B2067;
 Thu,  5 Sep 2019 04:10:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44B16B205F;
 Thu,  5 Sep 2019 04:10:44 +0000 (GMT)
Received: from [9.199.35.243] (unknown [9.199.35.243])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  5 Sep 2019 04:10:43 +0000 (GMT)
Subject: Re: [PATCH v8] libnvdimm/dax: Pick the right alignment default when
 creating dax devices
To: Dan Williams <dan.j.williams@intel.com>
References: <20190904065320.6005-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hD8SAFNNAWBP9q55wdPf-HYTEjpS4m+rT0VPoGodZULw@mail.gmail.com>
 <33b377ac-86ea-b195-fd83-90c01df604cc@linux.ibm.com>
 <CAPcyv4hBHjrTSHRkwU8CQcXF4EHoz0rzu6L-U-QxRpWkPSAhUQ@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <d46212fb-7bbb-3db8-5a65-2c8799021fd6@linux.ibm.com>
Date: Thu, 5 Sep 2019 09:40:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hBHjrTSHRkwU8CQcXF4EHoz0rzu6L-U-QxRpWkPSAhUQ@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-05_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050043
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux MM <linux-mm@kvack.org>, "Kirill A . Shutemov" <kirill@shutemov.name>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/5/19 8:29 AM, Dan Williams wrote:
>>> Keep this 'static' there's no usage of this routine outside of pfn_devs.c
>>>
>>>>    {
>>>> -       /*
>>>> -        * This needs to be a non-static variable because the *_SIZE
>>>> -        * macros aren't always constants.
>>>> -        */
>>>> -       const unsigned long supported_alignments[] = {
>>>> -               PAGE_SIZE,
>>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> -               HPAGE_PMD_SIZE,
>>>> +       static unsigned long supported_alignments[3];
>>>
>>> Why is marked static? It's being dynamically populated each invocation
>>> so static is just wasting space in the .data section.
>>>
>>
>> The return of that function is address and that would require me to use
>> a global variable. I could add a check
>>
>> /* Check if initialized */
>>    if (supported_alignment[1])
>>          return supported_alignment;
>>
>> in the function to updating that array every time called.
> 
> Oh true, my mistake. I was thrown off by the constant
> re-initialization. Another option is to pass in the storage since the
> array needs to be populated at run time. Otherwise I would consider it
> a layering violation for libnvdimm to assume that
> has_transparent_hugepage() gives a constant result. I.e. put this
> 
>          unsigned long aligns[4] = { [0] = 0, };
> 
> ...in align_store() and supported_alignments_show() then
> nd_pfn_supported_alignments() does not need to worry about
> zero-initializing the fields it does not set.

That requires callers to track the size of aligns array. If we add 
different alignment support later, we will end up updating all the call 
site?

How about?

static const unsigned long *nd_pfn_supported_alignments(void)
{
	static unsigned long supported_alignments[4];

	if (supported_alignments[0])
		return supported_alignments;

	supported_alignments[0] = PAGE_SIZE;

	if (has_transparent_hugepage()) {
		supported_alignments[1] = HPAGE_PMD_SIZE;
		if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
			supported_alignments[2] = HPAGE_PUD_SIZE;
	}

	return supported_alignments;
}

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
