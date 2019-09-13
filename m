Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9850B1724
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 04:12:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF7A0202E840B;
	Thu, 12 Sep 2019 19:12:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5771D202E6E15
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 19:12:52 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8D2CkAu136516; Thu, 12 Sep 2019 22:12:50 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uywkvy5ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 22:12:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8D2AB5O017443;
 Fri, 13 Sep 2019 02:12:11 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01dal.us.ibm.com with ESMTP id 2uyw58jej7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2019 02:12:11 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8D2C97N57737610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 02:12:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B79B0BE056;
 Fri, 13 Sep 2019 02:12:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91C01BE051;
 Fri, 13 Sep 2019 02:12:07 +0000 (GMT)
Received: from [9.199.46.176] (unknown [9.199.46.176])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2019 02:12:07 +0000 (GMT)
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <c2c734d3-ca8d-8485-9b9e-fd64e12aa0f0@linux.ibm.com>
Date: Fri, 13 Sep 2019 07:41:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911184332.GL20699@kadam>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-13_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909130022
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
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/12/19 12:13 AM, Dan Carpenter wrote:
> On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
>> +Coding Style Addendum
>> +---------------------
>> +libnvdimm expects multi-line statements to be double indented. I.e.
>> +
>> +        if (x...
>> +                        && ...y) {
> 
> That looks horrible and it causes a checkpatch warning.  :(  Why not
> do it the same way that everyone else does it.
> 
> 	if (blah_blah_x && <-- && has to be on the first line for checkpatch
> 	    blah_blah_y) { <-- [tab][space][space][space][space]blah
> 
> Now all the conditions are aligned visually which makes it readable.
> They aren't aligned with the indent block so it's easy to tell the
> inside from the if condition.


I came across this while sending patches to libnvdimm subsystem. W.r.t 
coding Style can we have consistent styles across the kernel? Otherwise, 
one would have to change the editor settings as they work across 
different subsystems in the kernel. In this specific case both 
clang-format and emacs customization tip in the kernel documentation 
directory suggest the later style.

-aneesh


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
