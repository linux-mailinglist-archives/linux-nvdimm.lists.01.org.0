Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681325BA0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 May 2019 03:23:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71DBD2126CFA9;
	Tue, 21 May 2019 18:23:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3C57B21250CBA
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 18:23:49 -0700 (PDT)
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF43621841;
 Wed, 22 May 2019 01:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558488228;
 bh=EfdCd+Wbln+Nh+BqZWk6BriTcOK5cZPujywXiaEIpRQ=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
 References:From;
 b=TWP9r+89q0sxw+WbEchJICU8NS/Vp4lLjz6MOOhf40aAIJgqcH7gxQDgMP2Y1oGbP
 AGl1lsRisHhrdMTX94i/QCT4CUTfEUAxmsNAVafI8jIXX7zKDUNZQyMaiCWGUeWXIP
 JYMR1k/WnPrKeJ5C8lIpvyLdlpIGs5APegV5A6v0=
Date: Wed, 22 May 2019 01:23:47 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY
 overhead
In-Reply-To: <155837931725.876528.6291628638777172042.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155837931725.876528.6291628638777172042.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-Id: <20190522012348.AF43621841@mail.kernel.org>
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
Cc: , Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 0aed55af8834 x86, uaccess: introduce copy_from_iter_flushcache for pmem / cache-bypass operations.

The bot has tested the following trees: v5.1.3, v5.0.17, v4.19.44, v4.14.120.

v5.1.3: Build OK!
v5.0.17: Build OK!
v4.19.44: Build OK!
v4.14.120: Failed to apply! Possible dependencies:
    6dfdb2b6d877 ("pmem: Switch to copy_to_iter_mcsafe()")
    976431b02c2e ("dax, dm: allow device-mapper to operate without dax support")
    98d82f48f198 ("dm log writes: add support for DAX")
    b3a9a0c36e1f ("dax: Introduce a ->copy_to_iter dax operation")


How should we proceed with this patch?

--
Thanks,
Sasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
