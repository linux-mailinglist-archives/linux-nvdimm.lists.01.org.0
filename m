Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAAC1F713A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jun 2020 02:12:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0A9D410096677;
	Thu, 11 Jun 2020 17:12:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=erik.kaneda@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BF96C10096677
	for <linux-nvdimm@lists.01.org>; Thu, 11 Jun 2020 17:12:09 -0700 (PDT)
IronPort-SDR: cF03wONylh1GrE8L1TPmQXFzJgZdD64mlNMPSlpuU/iYAFvpal5x+hLXr/U43T+PKltEuXNXnj
 NDGCGS1z+T4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 17:12:09 -0700
IronPort-SDR: WmSoRDXPlGay/stPwTrC0bJeqIZlezYfZxfcz9QvSlCD+EnCmo7s+5ejGCJT1kPtzKOoNxgMdn
 Bn0zpWUNpWaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400";
   d="scan'208";a="275505971"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2020 17:12:08 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 17:12:08 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 17:12:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 11 Jun 2020 17:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbnjKVdu0E6pdkfDs4popo8XXP36V3Rfqy0FPfuaEeqDnhwD+Ld4jABSUs1FAZtj1I4VyygXj+PX0m+/hb5Bu3RpI7S/2ALW+troN6p/R4GuC5Src80bDwBo1gLGxFVCOiVPzEHFayAvr/BbdwRQrbUU/S9nNmkxhfj0VSAeyWmsd1ndC/D2L+ysmqcNSs7kIZRYcQaH84z61JiHtpqVxrlWjO4dAPt8bgniHXU7cxet7TFImUNZQIOfybyvNZ4MLRr/2w6FrcZhY8ZfZToR0uuB4nEE1HxyVD3cGzIag/ae7MTVpk1G+deAa6Nrlb/crZP7UTWPJJP7U1TcE/ReZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1mCJL/rgevaraxb4tWpEHitB1U0L12764I9IxkjHz8=;
 b=kXM3H2ztrcBRWE4b/VVYuWloDdLHYqbaClnf6AlzBaG2SnAV6JPa3hug9DVehxccknY6JpgIKCEHAZffOgzLRzxF/FX/pbF39QTdsxVzK4sEfgRpE/elPhzHl/DsDMJCyVhvSef0Dvuo8re6OqxFyQr3/m0QilLLuw6GwbNKIRSP6c+NDMPzKKQYtRYP1zr+Sp6r9PHt2WshzAG6e8uldZem7+rO8/EpJGXqoZtcLBOJy6CtiqRCozNkTCwbOqV2tuzi9wG+FShw7C/bl2dkJ4X6AQPsJ6ks5lE+MQzYLLm9hL1bhDCzwHenOchAjz43e4LgpCcojQ8Qtj82h5uPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1mCJL/rgevaraxb4tWpEHitB1U0L12764I9IxkjHz8=;
 b=aIZOofC3o95xQunmUogj4/buHTBOXXydexmCvHXCC7oxE7X3VHaznz1STiz0Xa6t5zWYtgrgnX025fhgJlvheF5tes6QWqgiKzXMIqqi1be/xoHu5P8WB5tLFzRJF9fCnZTkAyMeVMfUDynBbyuQoacI5y0ymw4wkdyD7JIEnL8=
Received: from BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14)
 by BYAPR11MB3509.namprd11.prod.outlook.com (2603:10b6:a03:8e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Fri, 12 Jun
 2020 00:12:05 +0000
Received: from BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::ad0c:c6a9:6f39:eb92]) by BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::ad0c:c6a9:6f39:eb92%5]) with mapi id 15.20.3088.019; Fri, 12 Jun 2020
 00:12:05 +0000
From: "Kaneda, Erik" <erik.kaneda@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Williams, Dan J"
	<dan.j.williams@intel.com>
Subject: RE: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
 interpreter exit
Thread-Topic: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
 interpreter exit
Thread-Index: AQHWPyIKgbL3bQYNyEWDZiBdAuw+YqjUBIaQ
Date: Fri, 12 Jun 2020 00:12:05 +0000
Message-ID: <BYAPR11MB30963CB784B940A5CD58C4FAF0810@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <318372766.6LKUBsbRXE@kreacher> <3974162.pZLctmZ5Iv@kreacher>
In-Reply-To: <3974162.pZLctmZ5Iv@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669d60d8-bb16-4e59-9ecf-08d80e653d38
x-ms-traffictypediagnostic: BYAPR11MB3509:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3509AC253408E2334F4AA51DF0810@BYAPR11MB3509.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwOTmjTVJ20kNU7O3+TNlhTel6jGqhT4/tV1+qoJM7N4wcmRZjUlZFbwdE5g3+kbv23BnaKXQypBhKrzYV2Qy7/D2jTsAKPcVmrMPdB2lyNKWSbhOcVEC/JZOFWQ78YbE0w3DyUbYN7M6IQ7DUqVUQojLUZjpgMliQb6KQSDurhL+q0rxqBPCc16PgvM5hRpiryN1VHktKp2GiJTErpfnrEqEp13uyJbigNswrKxVpKRTZuaYXyTKUgCbGx7IRiBpcHH62RUY4iV5ghmHUyiXVq0M2EMgrCJlVJFrNaKt3eX+V4xeQ+pihjqpaoEZh9n8XERypDfNDUI2CiZ8HpYQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(376002)(346002)(366004)(52536014)(76116006)(66476007)(66946007)(66556008)(64756008)(54906003)(26005)(53546011)(7696005)(186003)(110136005)(33656002)(316002)(6506007)(83380400001)(66446008)(5660300002)(71200400001)(86362001)(2906002)(6636002)(4326008)(8936002)(7416002)(8676002)(478600001)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5SRndGw3YQNZkOAs6hZ9eWJEv0B13LdFuDtHlktbGMND350Ab2W556fQdpiITHR0fA2kjsE9r3fYXBnQjE6i/E+nr4zR5mhZjfD2lgegEUG481Nrkojn3IytDZcKk0Fk+UUVaHi9HQkXiUECRwEhgWXT14lw2Gwob4YjiCTo0B6QI4oSYQ23B8qsmAy9EOcgvZu95QAiJ7WBgFN0k3QkF35egx6qdesgts/mdgZoi4DcDFiFeQEWfLxcRYyckySKJcHRQ+BsJJCO/7orjIkLyDeK5G63NnYOC+ZWDAA0NVaSqCLkFsLEDktVP5xH+vPg5dmslU8ZWqQBBhyxLAWo6tkG5+ZHL3W95RuDxFOhDAjaqRgHlnlH0+esWrczSANy4tqCdkbWSwBiiRJkx78QGq+R4WMIq9KKdEKggAV2ic1G0Y8wyqJUlH7KoykRaBsiQsMuqXTwilQdtVMjYRgWoEBuOwtkEVjSauxfmWseOpqbloW23PoY/UUcGkkK81Ix
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 669d60d8-bb16-4e59-9ecf-08d80e653d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 00:12:05.2652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqOpQYKXidWgzEn8vC2xEDaxm6TDMIXxtCX8cjdw/yXJkRFyFWt7DwQb1zNg5LU8+mcl9bxwUopl/08uH7RH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3509
X-OriginatorOrg: intel.com
Message-ID-Hash: NT2GO6JTDWW5YJ5QN7BBPW2Y2URXGN6I
X-Message-ID-Hash: NT2GO6JTDWW5YJ5QN7BBPW2Y2URXGN6I
X-MailFrom: erik.kaneda@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Moore, Robert" <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NT2GO6JTDWW5YJ5QN7BBPW2Y2URXGN6I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Rafael J. Wysocki <rjw@rjwysocki.net>
> Sent: Wednesday, June 10, 2020 5:22 AM
> To: Williams, Dan J <dan.j.williams@intel.com>
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; Borislav
> Petkov <bp@alien8.de>; Weiny, Ira <ira.weiny@intel.com>; James Morse
> <james.morse@arm.com>; Myron Stowe <myron.stowe@redhat.com>;
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> nvdimm@lists.01.org; Moore, Robert <robert.moore@intel.com>
> Subject: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
> interpreter exit
> 
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> For transient memory opregions that are created dynamically under
> the namespace and interpreter mutexes and go away quickly, there
> still is the problem that removing their memory mappings may take
> significant time and so doing that while holding the mutexes should
> be avoided.
> 
> For example, unmapping a chunk of memory associated with a memory
> opregion in Linux involves running synchronize_rcu_expedited()
> which really should not be done with the namespace mutex held.
> 
> To address that problem, notice that the unused memory mappings left
> behind by the "dynamic" opregions that went away need not be unmapped
> right away when the opregion is deactivated.  Instead, they may be
> unmapped when exiting the interpreter, after the namespace and
> interpreter mutexes have been dropped (there's one more place dealing
> with opregions in the debug code that can be treated analogously).
> 
> Accordingly, change acpi_ev_system_memory_region_setup() to put
> the unused mappings into a global list instead of unmapping them
> right away and add acpi_ev_system_release_memory_mappings() to
> be called when leaving the interpreter in order to unmap the
> unused memory mappings in the global list (which is protected
> by the namespace mutex).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/acevents.h |  2 ++
>  drivers/acpi/acpica/dbtest.c   |  3 ++
>  drivers/acpi/acpica/evrgnini.c | 51
> ++++++++++++++++++++++++++++++++--
>  drivers/acpi/acpica/exutils.c  |  3 ++
>  drivers/acpi/acpica/utxface.c  | 23 +++++++++++++++
>  include/acpi/acpixf.h          |  1 +
>  6 files changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
> index 79f292687bd6..463eb9124765 100644
> --- a/drivers/acpi/acpica/acevents.h
> +++ b/drivers/acpi/acpica/acevents.h
> @@ -197,6 +197,8 @@ acpi_ev_execute_reg_method(union
> acpi_operand_object *region_obj, u32 function);
>  /*
>   * evregini - Region initialization and setup
>   */
> +void acpi_ev_system_release_memory_mappings(void);
> +
>  acpi_status
>  acpi_ev_system_memory_region_setup(acpi_handle handle,
>  				   u32 function,
> diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
> index 6db44a5ac786..7dac6dae5c48 100644
> --- a/drivers/acpi/acpica/dbtest.c
> +++ b/drivers/acpi/acpica/dbtest.c
> @@ -8,6 +8,7 @@
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "acdebug.h"
> +#include "acevents.h"
>  #include "acnamesp.h"
>  #include "acpredef.h"
>  #include "acinterp.h"
> @@ -768,6 +769,8 @@ acpi_db_test_field_unit_type(union
> acpi_operand_object *obj_desc)
>  		acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
>  		acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
> 
> +		acpi_ev_system_release_memory_mappings();
> +
>  		bit_length = obj_desc->common_field.bit_length;
>  		byte_length =
> ACPI_ROUND_BITS_UP_TO_BYTES(bit_length);
> 
> diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> index 48a5e6eaf9b9..946c4eef054d 100644
> --- a/drivers/acpi/acpica/evrgnini.c
> +++ b/drivers/acpi/acpica/evrgnini.c
> @@ -16,6 +16,52 @@
>  #define _COMPONENT          ACPI_EVENTS
>  ACPI_MODULE_NAME("evrgnini")
> 
> +#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
> +static struct acpi_mem_mapping *unused_memory_mappings;
> +
> +/*********************************************************
> **********************
> + *
> + * FUNCTION:    acpi_ev_system_release_memory_mappings
> + *
> + * PARAMETERS:  None
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Release all of the unused memory mappings in the queue
> + *              under the interpreter mutex.
> + *
> +
> **********************************************************
> ********************/
> +void acpi_ev_system_release_memory_mappings(void)
> +{
> +	struct acpi_mem_mapping *mapping;
> +
> +
> 	ACPI_FUNCTION_TRACE(acpi_ev_system_release_memory_mappin
> gs);
> +
> +	acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> +
> +	while (unused_memory_mappings) {
> +		mapping = unused_memory_mappings;
> +		unused_memory_mappings = mapping->next;
> +
> +		acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> +
> +		acpi_os_unmap_memory(mapping->logical_address,
> mapping->length);

acpi_os_unmap_memory calls synchronize_rcu_expedited(). I'm no RCU expert but the 
definition of this function states:

* Although this is a great improvement over previous expedited
 * implementations, it is still unfriendly to real-time workloads, so is
 * thus not recommended for any sort of common-case code.  In fact, if
 * you are using synchronize_rcu_expedited() in a loop, please restructure
 * your code to batch your updates, and then use a single synchronize_rcu()
 * instead.


> +		ACPI_FREE(mapping);
> +
> +		acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> +	}
> +
> +	acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> +
> +	return_VOID;
> +}
> +#else /* !ACPI_OS_MAP_MEMORY_FAST_PATH */
> +void acpi_ev_system_release_memory_mappings(void)
> +{
> +	return_VOID;
> +}
> +#endif /* !ACPI_OS_MAP_MEMORY_FAST_PATH */
> +
> 
> /**********************************************************
> *********************
>   *
>   * FUNCTION:    acpi_ev_system_memory_region_setup
> @@ -60,9 +106,8 @@ acpi_ev_system_memory_region_setup(acpi_handle
> handle,
>  				while (local_region_context->first_mapping)
> {
>  					mapping = local_region_context-
> >first_mapping;
>  					local_region_context->first_mapping
> = mapping->next;
> -					acpi_os_unmap_memory(mapping-
> >logical_address,
> -							     mapping->length);
> -					ACPI_FREE(mapping);
> +					mapping->next =
> unused_memory_mappings;
> +					unused_memory_mappings =
> mapping;
>  				}
>  #endif
>  			}
> diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
> index 8fefa6feac2f..516d67664392 100644
> --- a/drivers/acpi/acpica/exutils.c
> +++ b/drivers/acpi/acpica/exutils.c
> @@ -25,6 +25,7 @@
> 
>  #include <acpi/acpi.h>
>  #include "accommon.h"
> +#include "acevents.h"
>  #include "acinterp.h"
>  #include "amlcode.h"
> 
> @@ -106,6 +107,8 @@ void acpi_ex_exit_interpreter(void)
>  			    "Could not release AML Interpreter mutex"));
>  	}
> 
> +	acpi_ev_system_release_memory_mappings();
> +
>  	return_VOID;
>  }
> 
> diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
> index ca7c9f0144ef..d972696be846 100644
> --- a/drivers/acpi/acpica/utxface.c
> +++ b/drivers/acpi/acpica/utxface.c
> @@ -11,6 +11,7 @@
> 
>  #include <acpi/acpi.h>
>  #include "accommon.h"
> +#include "acevents.h"
>  #include "acdebug.h"
> 
>  #define _COMPONENT          ACPI_UTILITIES
> @@ -244,6 +245,28 @@ acpi_status acpi_purge_cached_objects(void)
> 
>  ACPI_EXPORT_SYMBOL(acpi_purge_cached_objects)
> 
> +/*********************************************************
> ********************
> + *
> + * FUNCTION:    acpi_release_unused_memory_mappings
> + *
> + * PARAMETERS:  None
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Remove memory mappings that are not used any more.
> + *
> +
> **********************************************************
> ******************/
> +void acpi_release_unused_memory_mappings(void)
> +{
> +	ACPI_FUNCTION_TRACE(acpi_release_unused_memory_mappings);
> +
> +	acpi_ev_system_release_memory_mappings();
> +
> +	return_VOID;
> +}
> +
> +ACPI_EXPORT_SYMBOL(acpi_release_unused_memory_mappings)
> +
> 
> /**********************************************************
> *******************
>   *
>   * FUNCTION:    acpi_install_interface
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 1dc8d262035b..8d2cc02257ed 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -449,6 +449,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  						    acpi_size length,
>  						    struct acpi_pld_info
>  						    **return_buffer))
> +ACPI_EXTERNAL_RETURN_VOID(void
> acpi_release_unused_memory_mappings(void))
> 
>  /*
>   * ACPI table load/unload interfaces
> --
> 2.26.2
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
