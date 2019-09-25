Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F654BD6E1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 05:54:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1151621962301;
	Tue, 24 Sep 2019 20:57:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 95FE6202BB9C2
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 20:57:09 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8P3pwW3033205; Tue, 24 Sep 2019 23:54:50 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v7xafcg13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Sep 2019 23:54:49 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8P3sQKT008180;
 Wed, 25 Sep 2019 03:54:49 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 2v5bg7k0rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2019 03:54:49 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8P3slwG63701476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Sep 2019 03:54:48 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFB11C6057;
 Wed, 25 Sep 2019 03:54:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C755C6055;
 Wed, 25 Sep 2019 03:54:46 +0000 (GMT)
Received: from [9.199.47.34] (unknown [9.199.47.34])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 25 Sep 2019 03:54:46 +0000 (GMT)
Subject: Re: [PATCH] libnvdimm/region: Update is_nvdimm_sync check to handle
 volatile regions
To: Dan Williams <dan.j.williams@intel.com>
References: <20190924114327.14700-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4iQbM5R0dukZX8wCQx4dD8NAevQWnHWe4hC7kHBcDcNow@mail.gmail.com>
 <CAPcyv4ij2+i9O15ZTx3VSLEF7wQM5ukfncVY42g4S1VWX8zTrA@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <886139c5-5941-1e51-95bf-9941d2276b95@linux.ibm.com>
Date: Wed, 25 Sep 2019 09:24:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ij2+i9O15ZTx3VSLEF7wQM5ukfncVY42g4S1VWX8zTrA@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-25_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250037
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Dan,

On 9/24/19 10:42 PM, Dan Williams wrote:
> On Tue, Sep 24, 2019 at 9:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Tue, Sep 24, 2019 at 4:43 AM Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>>>
>>> We should consider volatile regions synchronous so that we are resilient to
>>> OS crashes. This is needed when we have hypervisor like KVM exporting a ramdisk
>>> as pmem dimms.
>>
>> We have a hard time understanding what agent is being referenced when
>> we use "we" in a patch changelog. We would prefer that we consider not
>> using "we" in favor of explicitly named agents, or otherwise review
>> the changelog to make sure that "we" is clearly discernable. We will
>> fix it up this time when applying, but we hope we have made it clear
>> how confusing liberal use of "we" can be.
> 
> To be clear, I'm not strictly opposed to using "we" when it is
> established which we is being referred and stays constant throughout
> the description. This instance caught my eye again because the first
> couple "we"s seems to be the kernel, and the last we seems to be a
> user platform configuration.
> 

Thanks for the feedback. I will take extra care to clearly indicate the 
component/agent next time.

Thanks for taking the patch.

-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
