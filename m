Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9439DA2E65
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Aug 2019 06:31:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B4202021EBD7;
	Thu, 29 Aug 2019 21:33:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A85152020D32A
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 21:33:24 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7U4QnXE084609
 for <linux-nvdimm@lists.01.org>; Fri, 30 Aug 2019 00:31:34 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2upjrv2g5w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Fri, 30 Aug 2019 00:31:34 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 30 Aug 2019 05:31:32 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 30 Aug 2019 05:31:31 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7U4VU5Z47775774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2019 04:31:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F40C011C05B;
 Fri, 30 Aug 2019 04:31:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4548C11C058;
 Fri, 30 Aug 2019 04:31:29 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.37.186])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 30 Aug 2019 04:31:29 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
In-Reply-To: <156711523501.12658.8795324273505326478.git-patchwork-notify@kernel.org>
References: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
 <156711523501.12658.8795324273505326478.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2019 10:01:27 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19083004-0020-0000-0000-000003658360
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083004-0021-0000-0000-000021BADE2D
Message-Id: <87lfvbnujk.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-30_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300045
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

patchwork-bot+linux-nvdimm@kernel.org writes:

> Hello:
>
> This patch was applied to nvdimm/nvdimm.git (refs/heads/libnvdimm-for-next).
>
> On Wed,  7 Aug 2019 09:30:29 +0530 you wrote:
>> ndctl utility requires the ndbus to have unique names. If not while
>> enumerating the bus in userspace it drops bus with similar names.
>> This results in us not listing devices beneath the bus.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  drivers/nvdimm/of_pmem.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> Here is a summary with links:
>   - nvdimm/of_pmem: Provide a unique name for bus provider
>     https://git.kernel.org/nvdimm/nvdimm/c/49bddc73d15c25a68e4294d76fc74519fda984cd
>
> You are awesome, thank you!

We decided to fix this in ndctl tool? If we go with ndctl fix, we
can drop the kernel change. Parallely I am planning to do a  fix
for papr_scm driver that will update the provider name as "papr_scm". That
way we can find out the backend driver using

:~> ndctl list -B
[
  {
    "provider":"papr_scm",
    "dev":"ndbus1"
  },
  {
    "provider":"of_pmem",
    "dev":"ndbus0"
  }
]


-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
