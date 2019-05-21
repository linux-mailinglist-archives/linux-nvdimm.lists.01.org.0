Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A99245E8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 04:17:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 395682127421E;
	Mon, 20 May 2019 19:17:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=linux-nvdimm@lists.01.org 
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by ml01.01.org (Postfix) with ESMTP id 9CC71212735DD
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 19:17:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFE39341;
 Mon, 20 May 2019 19:17:15 -0700 (PDT)
Received: from [10.162.42.136] (p8cg001049571a15.blr.arm.com [10.162.42.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 E36A23F718; Mon, 20 May 2019 19:17:13 -0700 (PDT)
Subject: Re: [PATCH v2] mm, memory-failure: clarify error message
To: Jane Chu <jane.chu@oracle.com>, n-horiguchi@ah.jp.nec.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f1e4d5e9-e0a7-1a88-f5a5-de9a350e37ef@arm.com>
Date: Tue, 21 May 2019 07:47:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
Content-Language: en-US
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 05/21/2019 07:22 AM, Jane Chu wrote:
> Some user who install SIGBUS handler that does longjmp out
> therefore keeping the process alive is confused by the error
> message
>   "[188988.765862] Memory failure: 0x1840200: Killing
>    cellsrv:33395 due to hardware memory corruption"
> Slightly modify the error message to improve clarity.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
