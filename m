Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106652DA231
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 22:01:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C7AFE100EC1D8;
	Mon, 14 Dec 2020 13:01:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 122C4100EC1D5
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 13:00:59 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEKsHeE144093;
	Mon, 14 Dec 2020 21:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=aa0Ax+bPQnK4YL5LoY0LgelOl5GRjz9JrB0IR+sjwy4=;
 b=ZI3+5u9fy8oScjTCPSIf0nTtRFLUqT+rmE9ZY5kRukhi7zEbtkOhM1ANvHwO7nOCgi2N
 09NS9xbcnV9uICnIhloRb5nT4+Mh5wNP7E2k95vLT5yq+NicQHkzj3sQUClD2B63PCkV
 iu7c4BOhuH8BbVldQeT3+PcYmeGxEao0sfoVdwy+2ncWx6tfP07IUKuugxzSQ1vAxNZ5
 pJTECX1MndtEGJigCmXGolSHW7PE/aS5eQm8VB7s2G8lKqMpLyfPuJFhuE6+an4rhX3k
 hcUTsD8xzCT2fLlHKZAHeCpXJ53fwnhQjCpfUUdvlvCcRh04cKwzor65YmwqTBoBXiRI lg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 35cn9r7ftb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Dec 2020 21:00:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEKt5rf135821;
	Mon, 14 Dec 2020 20:58:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 35e6jq0b48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Dec 2020 20:58:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BEKwcf0020933;
	Mon, 14 Dec 2020 20:58:39 GMT
Received: from [10.159.141.221] (/10.159.141.221)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 14 Dec 2020 12:58:38 -0800
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
Date: Mon, 14 Dec 2020 12:58:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140140
Message-ID-Hash: EBDIAJ4TCGTDYCZB7FKXOHUT7WKAUDRE
X-Message-ID-Hash: EBDIAJ4TCGTDYCZB7FKXOHUT7WKAUDRE
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EBDIAJ4TCGTDYCZB7FKXOHUT7WKAUDRE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi, Shiyang,

On 11/22/2020 4:41 PM, Shiyang Ruan wrote:
> This patchset is a try to resolve the problem of tracking shared page
> for fsdax.
> 
> Change from v1:
>    - Intorduce ->block_lost() for block device
>    - Support mapped device
>    - Add 'not available' warning for realtime device in XFS
>    - Rebased to v5.10-rc1
> 
> This patchset moves owner tracking from dax_assocaite_entry() to pmem
> device, by introducing an interface ->memory_failure() of struct
> pagemap.  The interface is called by memory_failure() in mm, and
> implemented by pmem device.  Then pmem device calls its ->block_lost()
> to find the filesystem which the damaged page located in, and call
> ->storage_lost() to track files or metadata assocaited with this page.
> Finally we are able to try to fix the damaged data in filesystem and do

Does that mean clearing poison? if so, would you mind to elaborate 
specifically which change does that?

Thanks!
-jane

> other necessary processing, such as killing processes who are using the
> files affected.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
