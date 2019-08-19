Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3F92054
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Aug 2019 11:30:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B7F720218C31;
	Mon, 19 Aug 2019 02:32:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 92CE420215F63
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 02:32:24 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7J9MSJG097194
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 05:30:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ufp4uye45-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 05:30:55 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 19 Aug 2019 10:30:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 19 Aug 2019 10:30:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7J9Un0d22151242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2019 09:30:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 850604C04A;
 Mon, 19 Aug 2019 09:30:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A075A4C052;
 Mon, 19 Aug 2019 09:30:48 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.35.64])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2019 09:30:48 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 3/4] mm/nvdimm: Use correct #defines instead of open
 coding
In-Reply-To: <87v9ut1vev.fsf@linux.ibm.com>
References: <20190809074520.27115-1-aneesh.kumar@linux.ibm.com>
 <20190809074520.27115-4-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hc_-oGMp6jGVknnYs+rmj4W1A_gFCbmAX2LFw0hsfL5g@mail.gmail.com>
 <87v9ut1vev.fsf@linux.ibm.com>
Date: Mon, 19 Aug 2019 15:00:47 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19081909-4275-0000-0000-0000035AAE53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081909-4276-0000-0000-0000386CCA5F
Message-Id: <87mug5biyg.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-19_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190107
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:

> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Fri, Aug 9, 2019 at 12:45 AM Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>>>
>>

...

>>> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
>>> index 37e96811c2fc..c1d9be609322 100644
>>> --- a/drivers/nvdimm/pfn_devs.c
>>> +++ b/drivers/nvdimm/pfn_devs.c
>>> @@ -725,7 +725,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>>>                  * when populating the vmemmap. This *should* be equal to
>>>                  * PMD_SIZE for most architectures.
>>>                  */
>>> -               offset = ALIGN(start + SZ_8K + 64 * npfns, align) - start;
>>> +               offset = ALIGN(start + SZ_8K + sizeof(struct page) * npfns,
>>
>> I'd prefer if this was not dynamic and was instead set to the maximum
>> size of 'struct page' across all archs just to enhance cross-arch
>> compatibility. I think that answer is '64'.
>
>
> That still doesn't take care of the case where we add new elements to
> struct page later. If we have struct page size changing across
> architectures, we should still be ok as long as new size is less than what is
> stored in pfn superblock? I understand the desire to keep it
> non-dynamic. But we also need to make sure we don't reserve less space
> when creating a new namespace on a config that got struct page size >
> 64? 


How about

libnvdimm/pfn_dev: Add a build check to make sure we notice when struct page size change

When namespace is created with map device as pmem device, struct page is stored in the
reserve block area. We need to make sure we account for the right struct page
size while doing this. Instead of directly depending on sizeof(struct page)
which can change based on different kernel config option, use the max struct
page size (64) while calculating the reserve block area. This makes sure pmem
device can be used across kernels built with different configs.

If the above assumption of max struct page size change, we need to update the
reserve block allocation space for new namespaces created.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

1 file changed, 7 insertions(+)
drivers/nvdimm/pfn_devs.c | 7 +++++++

modified   drivers/nvdimm/pfn_devs.c
@@ -722,7 +722,14 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * The altmap should be padded out to the block size used
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
+		 *
+		 * Also make sure size of struct page is less than 64. We
+		 * want to make sure we use large enough size here so that
+		 * we don't have a dynamic reserve space depending on
+		 * struct page size. But we also want to make sure we notice
+		 * if we end up adding new elements to struct page.
 		 */
+		BUILD_BUG_ON(64 < sizeof(struct page));
 		offset = ALIGN(start + SZ_8K + 64 * npfns, align) - start;
 	} else if (nd_pfn->mode == PFN_MODE_RAM)
 		offset = ALIGN(start + SZ_8K, align) - start;


-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
