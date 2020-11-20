Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E66092BB3F0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 19:43:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 266D9100EBBB3;
	Fri, 20 Nov 2020 10:43:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 01471100ED484
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 10:43:09 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id oq3so14242370ejb.7
        for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 10:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWG6CUV3RIK6FRcfWDlUWaPCHMD6i3u8L9cc344l/ZI=;
        b=S0TOt6fHDESdJwK3Ace0+w4uisF6ORTa3OHhqLbQcMISwuGZEloIM3NDpuwkWLX3jc
         fkA+mBpPl1Wdn9EiI9fC9/nnwNQF4bYf+ggE3FbikCIXxIZj1VDiTCnTUpvPfKUueto4
         47XcHxZ+HRvWuMbX8xlJ7AlfPu9CipMcejCW7YsJDrOGJ1HkwSsDFaMU5hvBc+z6zZqF
         oWZMwAOwXozvGAdQuhZl2yq21MZI32UhRWCCbU+4rRKW1cIRN2dUe2oZc0WDj0phsoPJ
         xdSVhdtyugG/iHxWRzDwxsfNeiEnrd7/QU4DXLx9GvQGbsPHW7qKBCbBmuUZbDub1Kub
         4vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWG6CUV3RIK6FRcfWDlUWaPCHMD6i3u8L9cc344l/ZI=;
        b=rEEndz6ZxGWL9uYsOAIs+MGkRS3ev4Wpkir6ZgPOhPvyP7mx/F9RWqCqeRWTVSbpC6
         dsl35LTfpk6XXs26Qe5aXCxPqD7sAvoVazhZHvYm+jB3reEQBg2uvhVeIB36J6J4+QED
         be1OQ08dCM8kYw0kYy9bFSXbcZgen1ggLCPqhPKKG8bPwGSdXgkDlEmLU7dJNmV6O6ex
         MEVAoX8p9L2f+En91LjAC63OL0uhtVMzdf9IDVcd4yddAzKp63wEC/9+jUjzOhZJqn4x
         qDPZecrKNF/PTbF2szvGeKB7wxtYxDTAjO+PYsSoPZ+e8AbB+VhNKFGaS5vD7OZ1NcUZ
         /u7w==
X-Gm-Message-State: AOAM533DEerjmWlU8e0MuEGuo78fvoOqwMxt6s+BrWpiTz3b7Zr1lgWs
	B9qCQLfq7TCUyfxpu2Htnzyp+G0bpw5OvkM+T56O+w==
X-Google-Smtp-Source: ABdhPJzGGhvdpmWXuK+bFcP+csDTYmNEoWzduNtXQWYK60XEblraIPI6XJIniJSevq69L9VT5EQNg2tEp7BuZXZmwNU=
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr30194681ejb.264.1605897787978;
 Fri, 20 Nov 2020 10:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20201108121723.2089939-1-santosh@fossix.org>
In-Reply-To: <20201108121723.2089939-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 20 Nov 2020 10:42:57 -0800
Message-ID: <CAPcyv4jwUYTEXNtfEZkb3eApEgpiDebyNtppoWCc06nzQRGpuA@mail.gmail.com>
Subject: Re: [RFC v4 0/1] PMEM device emulation without nfit depenency
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: STK4LZBOGQJY3WDTJRO3OWHOLXAWIAJE
X-Message-ID-Hash: STK4LZBOGQJY3WDTJRO3OWHOLXAWIAJE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/STK4LZBOGQJY3WDTJRO3OWHOLXAWIAJE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 8, 2020 at 4:18 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> The current test module cannot be used for testing platforms (make check)
> that do not have support for NFIT. In order to get the ndctl tests working,
> we need a module which can emulate NVDIMM devices without relying on
> ACPI/NFIT.
>
> The emulated PMEM device is made part of the PAPR family.
>
> Corresponding changes for ndctl is also required, to add attributes needed
> for the test, which will be sent as a reply to this patch.
>
> The following is the test result, run on a x86 guest:

Just wanted to let you know I have not forgotten about this and will
be circling back to review it soon. Apologies for the delay.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
