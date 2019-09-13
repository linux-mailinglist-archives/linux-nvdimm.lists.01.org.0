Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C243B27DE
	for <lists+linux-nvdimm@lfdr.de>; Sat, 14 Sep 2019 00:04:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D660E202EA416;
	Fri, 13 Sep 2019 15:04:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0382B202E8428
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 15:04:26 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DM4FJG147041;
 Fri, 13 Sep 2019 22:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=cEmR1N7x+6nwpU4cpXCvEKl6j72A2b33JZR7hUchDTA=;
 b=KZdnhezRSz81h0NoDSiiyY3bSl/k6ofmBb2GPHi7B3lUCDeFHu37nnJFmwOCfU35uwbS
 5F3Bp57lbhxm6y/VCNab/Z8DVv39sSSf/4duU+f0BDVGq6TILMlPtzFEKBtS4gMt6XPp
 WF/nI+OHbNvbFZCUeNw22Fu37hEsRBpAjvShP1livRXAfQezyGIXnd+/I4u4f1a/aCfM
 vG3BQNvlcXf/VRRb4QgqzpCzFn9yxTPiexQhXF+V9F/3QS5MU8Sf0vFV/AtJ6YocsbSX
 YT6+K1udvqEeKgVA+YGbfe/osXluxufmPWIN3PJWIf6bn5aseY23M6BjZdo/Kt7skhth OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2uytd378q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 22:04:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DM4Esd012615;
 Fri, 13 Sep 2019 22:04:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2uytdju7a0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2019 22:04:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8DM3xGr008423;
 Fri, 13 Sep 2019 22:03:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Sep 2019 15:03:59 -0700
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com>
 <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
Date: Fri, 13 Sep 2019 18:03:56 -0400
In-Reply-To: <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org> (Bart Van Assche's
 message of "Thu, 12 Sep 2019 14:31:35 +0100")
Message-ID: <yq1tv9fdfar.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130218
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130218
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Steve French <stfrench@microsoft.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Hi Bart,

> On 9/11/19 5:40 PM, Martin K. Petersen wrote:
>> * Do not use custom To: and Cc: for individual patches. We want to see the
>>   whole series, even patches that potentially need to go through a different
>>   subsystem tree.
>
> Thanks for having written this summary. This is very helpful. For the
> above paragraph, should it be clarified whether that requirement
> applies to mailing list e-mail addresses only or also to individual
> e-mail addresses? When using git send-email it is easy to end up with
> different cc-lists per patch.

I prefer to have the entire series sent to linux-scsi or
target-devel. It wouldn't be so bad if discussions about the merits of a
tree-wide change consistently happened in responses to the cover
letter. But more often than not discussion happens in response to a
patch touching a different subsystem and therefore in a mail exchange
that doesn't end up on linux-scsi.

>> * The patch must compile without warnings (make C=1 CF="-D__CHECK_ENDIAN__")
>>   and does not incur any zeroday test robot complaints.
>
> How about adding W=1 to that make command?
>
> How about existing drivers that trigger tons of endianness warnings,
> e.g. qla2xxx? How about requiring that no new warnings are introduced?

This was in response to a driver submission (for a different driver)
around the time this doc was written. The problem is that it's sometimes
hard to distinguish new warnings from old ones. I'm all for requiring
that no new warnings are introduced.

>> * The patch must have a commit message that describes,
>> comprehensively and in plain English, what the patch does.
>
> How about making this requirement more detailed and requiring that not
> only what has been changed is document but also why that change has
> been made?

I'd really like all this patch submission guideline material to live in
Documentation/process. But yes.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
