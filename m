Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926E2DC800
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 21:55:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB939100EBBDE;
	Wed, 16 Dec 2020 12:55:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 768C2100EBBDC
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 12:55:48 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGKt92H053992;
	Wed, 16 Dec 2020 20:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=bJ/FpW+LtAOQAb0A6UXrq0pITxRjfgbAnbWgeqj4L80=;
 b=PYTmXtvuq85kys8XAxEQizEwBUhvN7t7e7Im0LCWhW0JOmZUaUqUq3j9SvWhw5ugLyN+
 prYnRVqO4OsVfc4UgC7ywQHdEWW7IVVhf9/h9nqqqEtDubbOLuQLP8k5KJTHVju2CZOI
 joIAS8I60ERyYu7haFxyU7VzirQs4X18Oxtyu5kjNpGOdYykHcIIovWPZX1PagoDdiMD
 ia9/owX+58cTZWdiGmEI+s4zFDBBlpkAEX3D57wE72aDzRfnae89oNF1h6f+koe1HHWD
 TyC96IBBTUtKhxWbh7Fr2R8TkSO7A8msZbT2NMVvjUkYnHnVQfOgeoKQ0Xn7cRRqcPDl bg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 35cn9rjfba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 20:55:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGKp944038651;
	Wed, 16 Dec 2020 20:55:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 35e6esejc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 20:55:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGKtWDH005843;
	Wed, 16 Dec 2020 20:55:33 GMT
Received: from [10.159.240.31] (/10.159.240.31)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 12:55:32 -0800
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
Date: Wed, 16 Dec 2020 12:55:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160130
Message-ID-Hash: TSK7L3JBLIIV5MRQW6STV337ZTHTEYWV
X-Message-ID-Hash: TSK7L3JBLIIV5MRQW6STV337ZTHTEYWV
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TSK7L3JBLIIV5MRQW6STV337ZTHTEYWV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi, Shiyang,

On 12/15/2020 4:14 AM, Shiyang Ruan wrote:
> The call trace is like this:
> memory_failure()
>   pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
>    gendisk->fops->corrupted_range() => - pmem_corrupted_range()
>                                        - md_blk_corrupted_range()
>     sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
>      xfs_rmap_query_range()
>       xfs_currupt_helper()
>        * corrupted on metadata
>            try to recover data, call xfs_force_shutdown()
>        * corrupted on file data
>            try to recover data, call mf_dax_mapping_kill_procs()
> 
> The fsdax & reflink support for XFS is not contained in this patchset.
> 
> (Rebased on v5.10)

So I tried the patchset with pmem error injection, the SIGBUS payload
does not look right -

** SIGBUS(7): **
** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **

I expect the payload looks like

** si_addr(0x7f3672e00000), si_lsb(0x15), si_code(0x4, BUS_MCEERR_AR) **

thanks,
-jane



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
