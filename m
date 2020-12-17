Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADB2DCCDC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 08:16:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7D10C100EB823;
	Wed, 16 Dec 2020 23:16:31 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8A5B100EB822
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 23:16:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z12so3152715pjn.1
        for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 23:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MsKo5NfDNKa97bhiMAyZ1x1XDzJdcZcHUH+hNhYSNn8=;
        b=Zc07h2maSPuyJP0vq+FfWIFm0zyuLeP9HM9vMpQSbxqvPxDvQc03saatWqRpJynWiX
         bPec/XzzOvkRMkEtYVz4wEgLnYm2ihrrzCglyjUDlhB0JT9QIU+sHPIHKNa98EWQnU8w
         b2HAzQvUOeHs5hLpgFkIYBnYrNGzZ5XComICV8atfviTwzOoGMmtXe/UfWOBwdJhpyEz
         N8ZPSyG2SA4kJOL92NtQuj6EopwGlkjf7GydzbRhIKfdbFqonwS5a012lGxqBaAhHxes
         Q2kA9Q0Anr8a7LJggBPNHq+frIUl67wCQsea/hInVbK3pdx0I2vZgHmMQE0JIovNvPvU
         OMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MsKo5NfDNKa97bhiMAyZ1x1XDzJdcZcHUH+hNhYSNn8=;
        b=U5NtPwJlzVd6QBrQtnzq4ETMS+hPtI0ThDzS3wXXCL4r+m4t4n7iRrOkZwdZ3b8TOy
         4gD18YBp3uLGfUaPrqVHBWgVnkMs8DviH7yHZQcomnbe3bRkOGtKF1vv78UEoJlVeI1d
         Iv9FwPxGTW9EtHBjB2zFgCZYbuRa16lJojK539S/rG2g+26d7sQXtpaqXVfy7VJmZcJW
         HUcVo76Alg1Q4FUDssRW1NSOmzq+kUVy1arBBD8WBfZQ2PMUxzRIqD8c/heYEoZAgZXw
         /3eLArrI1KN/8pDvHROz++vZE7hqA+ELpJ6uEHjrSx8eVCn1bFzPAOJ/VnmB5YBjWC15
         6cSQ==
X-Gm-Message-State: AOAM532jJ2S54QjZZjTFlUdnHlJ9n4V56fhJ+8l2HsoasA0SbgN7d4gL
	bEhkphQ9nVBcSfdmz6bwhRT2jA==
X-Google-Smtp-Source: ABdhPJzyQLt01dUJDMbXxb9HAFMv1W49XfI4fUEAh3atXk/y2qYydDaV2Oj01ycTYWEK07gh0zqT1g==
X-Received: by 2002:a17:902:830a:b029:da:df3b:459a with SMTP id bd10-20020a170902830ab02900dadf3b459amr9110623plb.75.1608189387359;
        Wed, 16 Dec 2020 23:16:27 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id cq15sm3878386pjb.27.2020.12.16.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 23:16:26 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC v5 1/7] testing/nvdimm: Add test module for non-nfit
 platforms
In-Reply-To: <CAPcyv4g-nAOPfBdkpeugXjaH=iBM5bg37wnSgszG7CT-sD069A@mail.gmail.com>
References: <20201214103859.2409175-1-santosh@fossix.org>
 <20201214103859.2409175-2-santosh@fossix.org>
 <CAPcyv4g-nAOPfBdkpeugXjaH=iBM5bg37wnSgszG7CT-sD069A@mail.gmail.com>
Date: Thu, 17 Dec 2020 12:46:24 +0530
Message-ID: <87tusk52d3.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: K7IKGQ2J4XBNMR6AW6Q6OMHO76NMFXYK
X-Message-ID-Hash: K7IKGQ2J4XBNMR6AW6Q6OMHO76NMFXYK
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K7IKGQ2J4XBNMR6AW6Q6OMHO76NMFXYK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Dec 14, 2020 at 2:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>>
>> The current test module cannot be used for testing platforms (make check)
>> that do not have support for NFIT. In order to get the ndctl tests working,
>> we need a module which can emulate NVDIMM devices without relying on
>> ACPI/NFIT.
>>
>> The aim of this proposed module is to implement a similar functionality to
>> the existing module but without the ACPI dependencies.
>>
>> This RFC series is split into reviewable and compilable chunks.
>>
>> This patch adds a new driver and registers two nvdimm bus needed for ndctl
>> make check.
>
> I'd like to be able to test either nfit_test or nd_test by environment
> variable from the same build. See the attached patch. Otherwise, if
> the ndctl release process is not constantly testing nd_test it *will*
> regress / bitrot.
>
> So, "make check" should try nfit_test.ko, fallback to nd_test.ko, or
> otherwise be forced to one or the other via an environment variable.
> For example I'd like the release process on x86 to be:
>
> make check
> NVDIMM_TEST_MOD=nd_test make check
>
> ...where the first invocation assumes to test nfit_test.ko.
>
> It needs some fixups to either prevent nfit_test and nd_test from
> being loaded at the same time, or fixups to allow them to coexist.
>
> This rework implies v5.11 is too aggressive a merge target.

Yes I agree. If you feel good about this series, I would like you to take this
and I can send the corresponding ndctl changes incrementally to work with the
patch you sent.

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
