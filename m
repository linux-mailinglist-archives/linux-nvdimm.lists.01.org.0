Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7833512CD25
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Dec 2019 07:03:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A3DF41011367C;
	Sun, 29 Dec 2019 22:06:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8462110113626
	for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 22:06:18 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 19so32495511otz.3
        for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 22:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTt/A5BYyvjJrihc3qsHFNSw61N4Hh8gtJ3xZHt8a3I=;
        b=DP60F/IcpPZgKmfkGs6DgypAKkbkXZw1ioZ9+afN1JiZ8umYI5efmBiKpnkHJbIiRX
         kernDZDxfkT5o94u8PduR8wFreO4KIPhe9gWKa2/VgrtOYe/gwxNBAyqvcfObG3xCZ16
         D5v2I4gezyUtMR0cLu4XjCyBmiAN0LVyomtGqcsySH9M1GBgbhlkr3meHO6BfmMSEbBD
         1gVCPmeMVcg+eoW7OhOXuOVEYeOj5ihR2BTezAhNqFyjim9nQMZFEs7yA6AK1WKUiH81
         i/OUf64JasKmbJEsLvIL2n+5CBW1JfSfQBa+2BUwvn/DzY6XjivxuN6yCgV/wYSuytyG
         B0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTt/A5BYyvjJrihc3qsHFNSw61N4Hh8gtJ3xZHt8a3I=;
        b=E7tTPY5y8e+/WNtPXZR4UVTN2itZoxH/X4QRK1K+wdWApN//WlISp3rIrNypTNDj36
         6kF0hDfCkMzUDN/pGIdc0Cju4AyhaiK2tv7Wa5lMrp3mAXdOLvvCgHx86IbZR9sEsSTB
         ZyEiqMhu8Yay4lVxLbU8aYRveib/cRchC6GgLNMTLFDWAG9vy5Z2P0dx2wCTkO+ew56d
         NcN/q6nVMxEh5HX8FISdkUPLuy3dqZ9+Qkw+1JdZ2MhcQfd81HOzF+ZOypIdw4cG2qKP
         QgOitudkapz1dm4V+AKrM3WRbbd3bL5H6VDXgSjPKGNra9Kl9xHEMJyc67v0HwbHdE5F
         xCdw==
X-Gm-Message-State: APjAAAVT959CbMFw2Hb9ytrccVCrvldgYBd8UiTmqwYb3xPGVXR8aTDt
	oUHRqXcHh84YvbgrmuAIeIURqCHJ7W49tuDiZ1Gw4w==
X-Google-Smtp-Source: APXvYqygAOxq99f8LVOB0T3U3bUBlYpWlWT/mAVzh/aRAkKX8zxB78R9LDZmmQBS2ZV85oaCcTTsjyfjR24o5WN/bC4=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr74429726otk.363.1577685777883;
 Sun, 29 Dec 2019 22:02:57 -0800 (PST)
MIME-Version: 1.0
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
 <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB32647968C27C92C1D3A5B7D8922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iU2xt9L1U7JXLoM1ex__KFHQ--6wdJeD2RNz6yfb87OQ@mail.gmail.com> <SN6PR11MB32643D4FCE4E828182CB78AF92240@SN6PR11MB3264.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB32643D4FCE4E828182CB78AF92240@SN6PR11MB3264.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Dec 2019 22:02:47 -0800
Message-ID: <CAPcyv4jEEKjpc8_Y0EBFH=4uHcTGGVpnSEOt425ARdTY3nuMqQ@mail.gmail.com>
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: 7T2VEQ34SSK7EZ4VQ5Y2TYX76E7GWPIN
X-Message-ID-Hash: 7T2VEQ34SSK7EZ4VQ5Y2TYX76E7GWPIN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7T2VEQ34SSK7EZ4VQ5Y2TYX76E7GWPIN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Dec 28, 2019 at 11:54 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> OK, got it.
> I have figured out the problem.
> I pass wrong parameter to util_daxctl_region_filter.
>
> But I found two other problems before I apply my patch.
>
> 1. DAX device already online after reconfigure it to system-ram.
>
> "$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
>
> If daxctl-device.sh do online-memory again,
> it makes FAIL daxctl-devices.sh (exit status: 1) even I add --no-online when reconfigure-device
>
> + ../daxctl/daxctl reconfigure-device -N -m system-ram --no-online dax0.0
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
> reconfigured 1 device
> [
>   {
>     "chardev":"dax0.0",
>     "size":262144000,
>     "target_node":0,
>     "mode":"system-ram",
>     "movable":false
>   }
> ]
> ++ daxctl_get_mode dax0.0
> ++ ../daxctl/daxctl list -d dax0.0
> ++ jq -er '.[].mode'
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
> + [[ system-ram == \s\y\s\t\e\m\-\r\a\m ]]
> + ../daxctl/daxctl online-memory dax0.0
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
> dax0.0:
>   WARNING: detected a race while onlining memory
>   Some memory may not be in the expected zone. It is
>   recommended to disable any other onlining mechanisms,
>   and retry. If onlining is to be left to other agents,
>   use the --no-online option to suppress this warning

This is likely because Ubuntu ships a udev rule that automatically
onlines hot-added memory. We've talked about a way to auto-detect when
a distribution ships a udev configuration like this, but for now this
warning message is the best we can do.

[..]>
> 2.  2 nvdimm will make daxctl-devices.sh FAIL

Do you mean a system with real nvdimms makes daxctl-devices.sh fail?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
