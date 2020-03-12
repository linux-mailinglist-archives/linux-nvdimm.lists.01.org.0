Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656ED1836E7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 18:08:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ACD5410FC378D;
	Thu, 12 Mar 2020 10:09:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE5C710FC378B
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 10:09:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h17so7041922otn.7
        for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnZsikVQ3dU9KHvCKd2cGzH/NybsIIzFB4kEy/ggnbU=;
        b=Jdi859buybi2SmteKOLWDvMSst/wdIskhHCsuWBywLHRNbpLL7CDHw0Wx02E8ZhWfZ
         LsISPQl3+W/afjIoGt7/tTLUC1AYL9AT4FQwXRQpOs7t4KfwbL8ShjqrUH/zd2/eaYeA
         4yXNeWVpQRtpg+K/A17aRrb8ZMsRYtB+fJgWc76KwjnkPqkqgMrCc1A2Wx+75clSezxp
         UIgTdK8aFqFxP76JfIN/6NUFySXf6D0Y668/LRIGRW0BTKtk2gkCE93peSXjwjsCCqDK
         cxB71Ooq4ucxNpwLgg749+exq0W9feVDf/Sm9Kf4hV/n5JOYrApv9xsKjNjStH/7HSLY
         9WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnZsikVQ3dU9KHvCKd2cGzH/NybsIIzFB4kEy/ggnbU=;
        b=SD7eVExWUxNdYcWYN2JXL4etINDDYRarovhcBu9OvP97QDnqCq6QO64eI/ZHPpyInL
         HOxO6sXZQQmeCsFTKWw3IbyLuzv2bBRHAXpeKcyj5QIUmlUMf6XVodLD9bdYT94o/fZT
         ZQITNkom3jK/uQ7B2HZshm2SygBZOjUf6wu57oPxIVJ3vx1vKD4IXR65Cqu+z9ucMB2C
         5lz8O9O4r67EFPbBka2HHud7B1G4PlYa7358HLatFieD334WQawc8wF4evFP6EJz/1er
         SAyP013NpHFRnRtZ/6aQ48YYmzDkYiHOIqBotSH0JsaQtSPqZEpRVmztYVrZqivpLvIK
         VLzQ==
X-Gm-Message-State: ANhLgQ0awiJIN+sILkbml8RJZALKWKFENXF1qWfMalhyRjljAPEDF4lc
	OvpBpiLgXQxnGJMmdMEOORNR6MnXQ+KnbH/aHVqDZg==
X-Google-Smtp-Source: ADFU+vu4JqyqdD0n1h0u/U3bHlvknFJXIUnPusQwrfQQRWj/WWsiiDxmtrL/DQeYzaUqtefZtw0QN3DrJ1viRPuBts4=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr6625269otl.71.1584032924323;
 Thu, 12 Mar 2020 10:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR11MB28641D4A1AF433086764A98D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <SN6PR11MB2864BBFAA6EC62A7747F9E5D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB2864BBFAA6EC62A7747F9E5D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Mar 2020 10:08:33 -0700
Message-ID: <CAPcyv4gXZKPyqu+9JmWuivw4Yuc05_Q+bbcjRAsHK2PWKtjwjg@mail.gmail.com>
Subject: Re: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Message-ID-Hash: RJJYQDIJMX23OX5I6DCKQRVUSRZEGMMP
X-Message-ID-Hash: RJJYQDIJMX23OX5I6DCKQRVUSRZEGMMP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RJJYQDIJMX23OX5I6DCKQRVUSRZEGMMP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 12, 2020 at 8:06 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
>
> Hi,
>
> [Resending the same, because the first e-mail got corrupted]
>
> I have inserted the 'nfit_test' module, removed it and reinserted it again (like in the previous e-mail " nfit_test: issue #2: modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter ") and called:
> $ ndctl disable-region all
> And got the following oops:
>
> [ 3079.971649] nfit_test: mcsafe_test: disabled, skip.
> [ 3080.030189] nfit_test nfit_test.0: failed to evaluate _FIT
> [ 3080.039150] nfit_test nfit_test.1: Error found in NVDIMM nmem4 flags: save_fail restore_fail flush_fail not_armed
> [ 3080.039159] nfit_test nfit_test.1: Error found in NVDIMM nmem5 flags: map_fail
> [ 3080.039696] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
> [ 3080.039805] pmem6: detected capacity change from 0 to 33554432
> [ 3080.039806] pmem7: detected capacity change from 0 to 4194304
> [ 3080.243372] pmem7: detected capacity change from 0 to 4194304
> [ 3080.251781] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
> [ 3080.251871] pmem6: detected capacity change from 0 to 33554432
> [ 3080.508112] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [ 3080.508117] #PF: supervisor read access in kernel mode
> [ 3080.508118] #PF: error_code(0x0000) - not-present page
> [ 3080.508120] PGD 0 P4D 0
> [ 3080.508123] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 3080.508126] CPU: 3 PID: 80123 Comm: pmempool Tainted: G           O      5.5.8-arch1-1-bb #1
> [ 3080.508128] Hardware name: System manufacturer System Product Name/RAMPAGE IV EXTREME, BIOS 4701 11/18/2013
> [ 3080.508133] RIP: 0010:dev_dax_huge_fault+0x2b3/0x570 [device_dax]

If you force loaded a module with unresolved symbols all bets are off,
lets get "make TESTS=libndctl check" running cleanly before trying to
debug this report.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
