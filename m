Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BA6C4FA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 04:29:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F38C6212C01F3;
	Wed, 17 Jul 2019 19:31:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CE61E212C01EA
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 19:31:40 -0700 (PDT)
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4E5420693;
 Thu, 18 Jul 2019 02:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563416952;
 bh=2al5dDB1QGuCWB3Crm/8rt8z8AxFdOWfnkgmI4UzPSc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PU/9ZjOIjOfP/JFyzI5gfIjK6E62q03dwuuvLF2mL1b+ZBi3Tkg1MajanCgM/uVEG
 e+LyDtZ/Tr8sO60aevE5G5MgcPIiLeMk6TuIFZyLSa141UgiOiobEl5AyHJwY8Uuyr
 Lz3uaee2o4zEAnjP69PTvk7SRKwSmJ6zIlF83MfY=
Date: Thu, 18 Jul 2019 11:29:09 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/7] drivers/base: Introduce kill_device()
Message-ID: <20190718022909.GB15376@kroah.com>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156341207332.292348.14959761496009347574.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156341207332.292348.14959761496009347574.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 06:07:53PM -0700, Dan Williams wrote:
> The libnvdimm subsystem arranges for devices to be destroyed as a result
> of a sysfs operation. Since device_unregister() cannot be called from
> an actively running sysfs attribute of the same device libnvdimm
> arranges for device_unregister() to be performed in an out-of-line async
> context.
> 
> The driver core maintains a 'dead' state for coordinating its own racing
> async registration / de-registration requests. Rather than add local
> 'dead' state tracking infrastructure to libnvdimm device objects, export
> the existing state tracking via a new kill_device() helper.
> 
> The kill_device() helper simply marks the device as dead, i.e. that it
> is on its way to device_del(), or returns that the device was already
> dead. This can be used in advance of calling device_unregister() for
> subsystems like libnvdimm that might need to handle multiple user
> threads racing to delete a device.
> 
> This refactoring does not change any behavior, but it is a pre-requisite
> for follow-on fixes and therefore marked for -stable.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: 4d88a97aa9e8 ("libnvdimm, nvdimm: dimm driver and base libnvdimm device-driver...")
> Cc: <stable@vger.kernel.org>
> Tested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
