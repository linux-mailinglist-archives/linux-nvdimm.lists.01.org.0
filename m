Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1F6D7E9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jul 2019 02:45:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0DA99212BF573;
	Thu, 18 Jul 2019 17:48:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C7BAD212B7D90
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 17:47:59 -0700 (PDT)
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C503221850;
 Fri, 19 Jul 2019 00:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563497133;
 bh=7Ow720wmxKpOQyJcgbX6HephCRldKnUNpWgwTShdz6I=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:References:
 From;
 b=t9btvueopx7TqlZWUqxH0VE11z5MXhIaXioz3KDVUPLXRn0hPFU5smGdRz9N3aQ8/
 63UMZkUOZuEj2PUi0p9lwyBRAqq4Ki8Pqhsa7WQIW8H4ECCBH+lF62laNWSUtAKcDq
 AQUUSoLoA2PGBXvXarY6enLbDRhFn9TNvrgCUx4c=
Date: Fri, 19 Jul 2019 00:45:32 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 1/7] drivers/base: Introduce kill_device()
In-Reply-To: <156341207332.292348.14959761496009347574.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156341207332.292348.14959761496009347574.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-Id: <20190719004532.C503221850@mail.kernel.org>
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
Cc: , Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 4d88a97aa9e8 libnvdimm, nvdimm: dimm driver and base libnvdimm device-driver infrastructure.

The bot has tested the following trees: v5.2.1, v5.1.18, v4.19.59, v4.14.133, v4.9.185, v4.4.185.

v5.2.1: Build OK!
v5.1.18: Build OK!
v4.19.59: Failed to apply! Possible dependencies:
    3451a495ef24 ("driver core: Establish order of operations for device_add and device_del via bitflag")

v4.14.133: Failed to apply! Possible dependencies:
    3451a495ef24 ("driver core: Establish order of operations for device_add and device_del via bitflag")

v4.9.185: Failed to apply! Possible dependencies:
    3451a495ef24 ("driver core: Establish order of operations for device_add and device_del via bitflag")

v4.4.185: Failed to apply! Possible dependencies:
    3451a495ef24 ("driver core: Establish order of operations for device_add and device_del via bitflag")
    656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from bus_type.match()")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
