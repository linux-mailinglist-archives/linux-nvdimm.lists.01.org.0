Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C582AAE
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 07:05:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27C452130D7D9;
	Mon,  5 Aug 2019 22:08:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D5D692130A4E5
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 22:08:26 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7652UK1147354
 for <linux-nvdimm@lists.01.org>; Tue, 6 Aug 2019 01:05:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u730t881d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Tue, 06 Aug 2019 01:05:55 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
 Tue, 6 Aug 2019 06:05:53 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Aug 2019 06:05:52 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x7655XWP38076802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Aug 2019 05:05:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7855E4C046;
 Tue,  6 Aug 2019 05:05:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E4A24C044;
 Tue,  6 Aug 2019 05:05:48 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.195.181])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue,  6 Aug 2019 05:05:47 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation);
 Tue, 06 Aug 2019 10:35:47 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
 "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] ndctl,
 check: Ensure mmap of BTT sections work with 64K page-size
In-Reply-To: <2cc108a1f65fb008670c272473df40e51e97b9ad.camel@intel.com>
References: <20190704025143.22856-1-vaibhav@linux.ibm.com>
 <b01607421be5f487662e973c30967a0bf8a8389d.camel@intel.com>
 <878ss721yq.fsf@vajain21.in.ibm.com>
 <2cc108a1f65fb008670c272473df40e51e97b9ad.camel@intel.com>
Date: Tue, 06 Aug 2019 10:35:47 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19080605-0012-0000-0000-0000033A6D1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080605-0013-0000-0000-00002174257C
Message-Id: <875zna289g.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-06_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060059
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
Cc: "harish@linux.ibm.com" <harish@linux.ibm.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Mon, 2019-08-05 at 18:39 +0530, Vaibhav Jain wrote:
>> Thanks for reviewing this patch Vishal. I have prepped a v2 adressing
>> all your review comments with one exception below:
>
> No problem, thanks for fixing this.
>
>> 
>> "Verma, Vishal L" <vishal.l.verma@intel.com> writes:
>> 
>> > On Thu, 2019-07-04 at 08:21 +0530, Vaibhav Jain wrote:
>> > > 
>> > 
>> > > +	if (addr != MAP_FAILED)
>> > > +		addr = (void *) ((uintptr_t)addr + shift);
>> > 
>> > The (uintptr_t) cast should be ok to drop, for v66 we are removing
>> > the
>> > pointer arithmatic warning:
>> > https://patchwork.kernel.org/patch/11062697/
>> > 
>> > In fact, since 'shift' is in bytes, isn't an unsigned int cast
>> > actually *wrong*?
>> Not sure if I understand your review comment correctly. With uintptr_t
>> cast and 'shift' in bytes, addr will be assigned 'addr + shift'
>> instead
>> of 'addr + shift * sizeof (unsigned int)'
>> 
>> So I think the arithmetic I am doing here is correct.
>> 
> Yes you're right - I conflated a (uintptr_t) cast with an (unsigned int)
> cast. The latter would actually be wrong, but I see now that uintptr_t
> is correct. However, given the above patch where we drop the pointer
> arithmetic warning, I think it should be OK to manipulate the void
> pointer directly, and this makes the line cleaner and more concise.
>
> Thanks,
> 	-Vishal

Sure agreed. I have sent out a v2 patch titled "[PATCH v2] ndctl, check:
Ensure mmap of BTT sections work with 64K page-sizes" with the changes.

Thanks,
-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
