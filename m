Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD95162F87
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 20:13:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CF50100780A1;
	Tue, 18 Feb 2020 11:14:12 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vajain21@vajain21.in.ibm.com.in.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50A111007A827
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 11:14:11 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IJAOaH050747
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 14:13:18 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8hwnh9hg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 14:13:18 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vajain21@vajain21.in.ibm.com.in.ibm.com>;
	Tue, 18 Feb 2020 19:13:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 18 Feb 2020 19:13:14 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01IJDDsT58654866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2020 19:13:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7FAF42045;
	Tue, 18 Feb 2020 19:13:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F834203F;
	Tue, 18 Feb 2020 19:13:10 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.60.35])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 18 Feb 2020 19:13:09 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Wed, 19 Feb 2020 00:43:08 +0530
From: Vaibhav Jain <vajain21@vajain21.in.ibm.com.in.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH] ndctl,daxctl: Ensure allocated contexts are released before exit
In-Reply-To: <CAPcyv4isdnEi=-EOv5EVu=6u7D32eLFLGWK0K5nQZa+9SMMGkQ@mail.gmail.com>
References: <20200218155314.89123-1-vaibhav@linux.ibm.com> <CAPcyv4isdnEi=-EOv5EVu=6u7D32eLFLGWK0K5nQZa+9SMMGkQ@mail.gmail.com>
Date: Wed, 19 Feb 2020 00:43:08 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20021819-0028-0000-0000-000003DC34D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021819-0029-0000-0000-000024A13F11
Message-Id: <87lfozk8u3.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_05:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=1 bulkscore=0 adultscore=0 clxscore=1034
 priorityscore=1501 mlxlogscore=844 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180129
Message-ID-Hash: FMWUTFTBPQDDVKBOQL376G4XLC6BWGL4
X-Message-ID-Hash: FMWUTFTBPQDDVKBOQL376G4XLC6BWGL4
X-MailFrom: vajain21@vajain21.in.ibm.com.in.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FMWUTFTBPQDDVKBOQL376G4XLC6BWGL4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Tue, Feb 18, 2020 at 7:53 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
>> Presently main_handle_internal_command() will simply call exit() on
>> the return value from run_builtin(). This prevents release of allocated
>> contexts 'struct ndctl_ctx' or 'struct daxctl_ctx' when the main
>> thread exits.
>>
>
> There is ultimately no leak since process exit cleans up all
> resources. Does this address a functional problem, or is it just a
> hygiene fixup?

I am trying to implement support for a new dimm type in ndctl and was
trying to debug a potential memory leak via valgrind/memcheck when came
across this issue. Without this patch, memcheck reports lots of leaking
reachable memory at ndctl exit that made the task of isolating real leak
bit problematic.

Below are the run logs of a 'ndctl list' command without and with the
patch applied.

# Without the patch
$ valgrind --leak-check=full ndctl/.libs/ndctl list  
==132738== Memcheck, a memory error detector
==132738== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==132738== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
==132738== Command: ndctl/.libs/ndctl list
==132738== 
==132738== 
==132738== HEAP SUMMARY:
==132738==     in use at exit: 16,564 bytes in 264 blocks
==132738==   total heap usage: 920 allocs, 656 frees, 466,916 bytes allocated
==132738== 
==132738== LEAK SUMMARY:
==132738==    definitely lost: 0 bytes in 0 blocks
==132738==    indirectly lost: 0 bytes in 0 blocks
==132738==      possibly lost: 0 bytes in 0 blocks
==132738==    still reachable: 16,564 bytes in 264 blocks
==132738==         suppressed: 0 bytes in 0 blocks
==132738== Reachable blocks (those to which a pointer was found) are not shown.
==132738== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==132738== 
==132738== For lists of detected and suppressed errors, rerun with: -s
==132738== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)


# With the patch applied
$ valgrind --leak-check=full ndctl/.libs/ndctl list 
==132759== Memcheck, a memory error detector
==132759== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==132759== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
==132759== Command: ndctl/.libs/ndctl list
==132759== 
==132759== 
==132759== HEAP SUMMARY:
==132759==     in use at exit: 0 bytes in 0 blocks
==132759==   total heap usage: 920 allocs, 920 frees, 466,916 bytes allocated
==132759== 
==132759== All heap blocks were freed -- no leaks are possible
==132759== 
==132759== For lists of detected and suppressed errors, rerun with: -s
==132759== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
